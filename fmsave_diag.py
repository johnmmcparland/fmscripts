"""fmsave diagnostics for https://github.com/rhiever/fmsave/issues/2

Usage:  python fmsave_diag.py path/to/career.fm
Writes fmsave-diag.txt next to this script and prints the same text.

Reads the save without changing it. It prints no player, club, or manager names and no
file paths: only version strings, section sizes, the first bytes of `game_info` (version
strings, engine flags, and rule-group names), and fmsave's own structural validation report.
"""

import json
import platform
import struct
import sys
import traceback
import warnings
from pathlib import Path

import fmsave
import fmsave._version as fv
from fmsave._container import read_index, read_section
from fmsave._scan import read_length_prefixed_string

STEAM_BUILD_NUMBER = 2329565
RULE_MARKER = b"RULE_GROUP_MANAGER"

save_path = Path(sys.argv[1])
lines: list[str] = []


def out(text: str = "") -> None:
    lines.append(text.replace(str(save_path), "<save>").replace(save_path.name, "<save>"))


def u32_hits(buffer: bytes, value: int, base: int) -> list[int]:
    needle = struct.pack("<I", value)
    hits, start = [], buffer.find(needle)
    while start != -1:
        hits.append(start - base)
        start = buffer.find(needle, start + 1)
    return hits


out(f"fmsave {fmsave.__version__} | Python {platform.python_version()} | {platform.platform()}")

# 1. Versions and the game_info layout
idx = read_index(save_path)
version = fv.read_summary_facts(idx).version
gi = read_section(idx, "game_info")
db_version, end = read_length_prefixed_string(gi, 8, 64)
rule_at = gi.find(RULE_MARKER)
out(f"\n== game_info ==\nbuild {version.build} | db_version {db_version!r} | db_version ends at {end} | length {len(gi)}")
out(f"build {version.build_number} as u32 at (relative to db_version end): {u32_hits(gi, version.build_number, end)}")
out(f"Steam build {STEAM_BUILD_NUMBER} as u32 at: {u32_hits(gi, STEAM_BUILD_NUMBER, end)}")
out(f"RULE_GROUP_MANAGER at: {rule_at - end if rule_at != -1 else None}")
dump_end = (rule_at + 40) if rule_at != -1 else end + 300
chunk = gi[end:dump_end]
out("bytes from db_version end (offset: 16 bytes per row):")
for row in range(0, len(chunk), 16):
    out(f"  {row:4d}: {chunk[row:row + 16].hex(' ')}")

# 2. Section table (names, schema numbers and sizes only)
out("\n== sections ==")
heads = fv.read_section_heads(idx, list(idx.sections), fv.SECTION_HEAD_BYTES)
for name, entry in idx.sections.items():
    try:
        schema = fv.section_schema(heads[name], entry.extension, name, "<save>")
    except Exception as error:  # noqa: BLE001
        schema = f"? ({type(error).__name__})"
    out(f"  {name:40s} ext={entry.extension!r:8s} schema={schema!s:6s} size={entry.decompressed_size}")

# 3. Open the save past the game_info build check and run every reader
original_read_game_info_facts = fv.read_game_info_facts


def lenient_read_game_info_facts(*args, **kwargs):
    try:
        return original_read_game_info_facts(*args, **kwargs)
    except fmsave.ReaderCheckError as error:
        out(f"\n(game_info check bypassed: {error})")
        return fv.GameInfoFacts(db_version=db_version, game_date=None, time_slot=0)


fv.read_game_info_facts = lenient_read_game_info_facts
out("\n== validate (structural only) ==")
with warnings.catch_warnings(record=True) as caught:
    warnings.simplefilter("always")
    try:
        with fmsave.open(save_path) as career_save:
            report = fmsave.validate_save(career_save)
            for reader in report.readers:
                failed = [
                    f"{gate.name}={gate.observed} (min {gate.minimum}, max {gate.maximum})"
                    for gate in reader.gates
                    if gate.applied and not gate.passed
                ]
                line = f"  {reader.reader:20s} {reader.status:7s} records={reader.record_count}"
                if failed:
                    line += " | failed: " + "; ".join(failed)
                if reader.anomalies:
                    line += f" | anomalies: {json.dumps(dict(reader.anomalies))}"
                out(line)
            # validate hides error text; fmsave's errors hold only structural facts, so show them
            for reader in report.readers:
                if reader.status == "ok":
                    continue
                try:
                    getattr(career_save, reader.reader)()
                except Exception as error:  # noqa: BLE001
                    out(f"  {reader.reader} error: {type(error).__name__}: {error}")
    except Exception:  # noqa: BLE001
        out(traceback.format_exc())
for warning in caught:
    out(f"warning: {warning.category.__name__}: {warning.message}")

text = "\n".join(lines)
print(text)
Path(__file__).with_name("fmsave-diag.txt").write_text(text, encoding="utf-8")