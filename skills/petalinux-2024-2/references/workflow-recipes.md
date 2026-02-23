# PetaLinux 2024.2 Workflow Recipes

## 1. New Project from BSP

1. Create project:
`petalinux-create project -s <board>.bsp`
2. Enter project directory and import/verify hardware settings:
`petalinux-config`
3. Build all images:
`petalinux-build`
4. Package boot image for target boot chain:
`petalinux-package boot ...`
5. Boot for first validation:
`petalinux-boot <jtag|qemu> ...`

## 2. New Project from Template + XSA

1. Create project:
`petalinux-create project --template <versal|zynqMP|zynq|microblaze> --name <project>`
2. Import hardware:
`petalinux-config --get-hw-description=<path-to-xsa-or-export-dir>`
3. Configure rootfs/kernel/device-tree as needed:
`petalinux-config -c rootfs`
`petalinux-config -c kernel`
4. Build and package:
`petalinux-build`
`petalinux-package boot ...`

## 3. Iterative Component Development

1. Reconfigure one component:
`petalinux-config -c <component>`
2. Rebuild targeted component:
`petalinux-build -c <component>`
3. Run an explicit task when needed:
`petalinux-build -c <component> -x <task>`
4. Use source-level workflows:
`petalinux-devtool ...`

## 4. Packaging Variants

- Boot image packaging:
`petalinux-package boot ...`
- Prebuilt deliverables:
`petalinux-package prebuilt ...`
- Toolchain/sysroot handoff:
`petalinux-package sysroot ...`
- SD/eMMC image flow:
`petalinux-package wic ...`
- BSP redistribution:
`petalinux-package bsp ...`

## 5. Debug and Bring-Up

- Quick boot:
`petalinux-boot qemu ...` or `petalinux-boot jtag ...`
- GDB and helpers:
`petalinux-util gdb ...`
`petalinux-util xsdb-connect ...`
`petalinux-util find-xsa-bitstream ...`

## 6. Upgrade Path

1. Back up project and confirm target release.
2. Upgrade tool/project as required:
`petalinux-upgrade ...`
3. Re-import hardware if platform changed.
4. Rebuild and rerun boot validation checks.
