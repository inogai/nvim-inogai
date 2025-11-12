#!/usr/bin/env python3
"""Update lze_specs/init.lua files"""

import os
from pathlib import Path
from textwrap import dedent


PROJECT_ROOT = Path(__file__).resolve().parent.parent

INIT_ROOT = PROJECT_ROOT / "lua" / "lze_specs"


def collect_files(directory: Path):
    it = directory.iterdir()
    it = filter(lambda p: p.suffix == ".lua", it)
    it = filter(lambda p: p.name != "init.lua", it)

    return list(it)


def create_init_file(directory: Path):
    template = "return {"

    for p in collect_files(directory):
        p = p.relative_to(PROJECT_ROOT / "lua")
        p = ".".join(p.parts)
        p = p.removesuffix(".lua")
        template += f"\n  {{ import = '{p}' }},"

    template = template.removesuffix(",")

    template += "\n}"

    return template


def write_init_file(directory: Path):
    init_content = create_init_file(directory)

    init_path = directory / "init.lua"
    with open(init_path, "w") as f:
        _ = f.write(init_content)


if __name__ == "__main__":
    write_init_file(INIT_ROOT)
