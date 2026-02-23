---
name: petalinux-2024-2
description: PetaLinux 2024.2 project workflows for AMD embedded Linux targets. Use when handling petalinux-create/config/build/package/boot/util/devtool/upgrade tasks, UG1144 guidance, BSP and XSA import, rootfs/kernel/device-tree customization, image packaging, JTAG/QEMU boot, and bring-up/debug of Zynq, Zynq UltraScale+, Versal, or MicroBlaze projects.
---

# PetaLinux 2024.2

## Overview

Use this skill to map user goals to the right `petalinux-*` commands and execution order for version 2024.2.

## Workflow

1. Confirm context:
- Find the board/SoC family, boot medium, and whether the user starts from BSP, XSA, or an existing project.
- Confirm the installed tool version when possible (startup banner, environment setup output, or local `petalinux-*-help` output).

2. Choose the path:
- New project: use `petalinux-create`, then `petalinux-config`, then `petalinux-build`.
- Existing project updates: use `petalinux-config` and targeted `petalinux-build`/`petalinux-package`.
- Boot and debug: use `petalinux-boot`, `petalinux-util`, and `petalinux-devtool`.
- Tool/project migration: use `petalinux-upgrade`.

3. Apply conservative command guidance:
- Prefer exact syntax from local `--help` output when available.
- If a flag is uncertain, provide a safe template and explicitly mark placeholders.
- Keep project-local changes (`project-spec/meta-user`) intact unless the user asks to reset.

## Quick Command Map

- Create project from BSP: `petalinux-create project -s <vendor-board>.bsp`
- Create project from template: `petalinux-create project --template <versal|zynqMP|zynq|microblaze> --name <project>`
- Import hardware platform: `petalinux-config --get-hw-description=<path-to-xsa-or-export-dir>`
- Configure system/rootfs/kernel/u-boot: `petalinux-config` or `petalinux-config -c <component>`
- Build full image: `petalinux-build`
- Build one component: `petalinux-build -c <component>`
- Run build task: `petalinux-build -c <component> -x <task>`
- Package boot artifacts: `petalinux-package boot ...`
- Package other outputs: `petalinux-package <bsp|prebuilt|sysroot|wic> ...`
- Boot for debug/bring-up: `petalinux-boot <jtag|qemu> ...`
- Utility helpers: `petalinux-util <gdb|dfu-util|xsdb-connect|find-xsa-bitstream> ...`
- Project/tool upgrade: `petalinux-upgrade ...`

## References

- Command and section index: `references/command-index.md`
- Ready-to-adapt flows: `references/workflow-recipes.md`
- PDF extraction helper: `scripts/extract_ug1144_index.sh`
- Environment checker: `scripts/check_petalinux_env.sh`
