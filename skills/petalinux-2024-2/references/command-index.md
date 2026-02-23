# PetaLinux 2024.2 Command Index

## Source

- Local PDF: `/Users/fredrikcarlsson/Downloads/ug1144-petalinux-tools-reference-guide-en-us-2024.2.pdf`
- Online command pages (UG1144):
  - `petalinux-create project`
  - `petalinux-config`
  - `petalinux-build`
  - `petalinux-boot`
  - `petalinux-package`
  - `petalinux-util`
  - `petalinux-upgrade`
  - `petalinux-devtool`

## Command Intent Summary

- `petalinux-create`: create projects and software components.
- `petalinux-config`: configure hardware import and software settings.
- `petalinux-build`: compile selected or all components in a project.
- `petalinux-boot`: boot Linux images through JTAG or QEMU.
- `petalinux-package`: package boot/prebuilt/sysroot/wic/bsp outputs.
- `petalinux-util`: utility functions for debug and platform helpers.
- `petalinux-upgrade`: minor release and platform upgrade operations.
- `petalinux-devtool`: customize component source and recipe workflows.

## Subcommand Topics Seen in UG1144 2024.2

- `petalinux-create project`
- `petalinux-create apps/modules`
- `petalinux-config --get-hw-description`
- `petalinux-config -c COMPONENT`
- `petalinux-build --component`
- `petalinux-build --execute` / `-x`
- `petalinux-boot jtag`
- `petalinux-boot qemu`
- `petalinux-package boot`
- `petalinux-package bsp`
- `petalinux-package prebuilt`
- `petalinux-package sysroot`
- `petalinux-package wic`
- `petalinux-util gdb`
- `petalinux-util dfu-util`
- `petalinux-util xsdb-connect`
- `petalinux-util find-xsa-bitstream`

## Usage Notes

- Treat local `--help` output as the final authority for exact flags in the current install.
- Keep placeholders explicit in generated commands: `<project>`, `<bsp>`, `<xsa>`, `<component>`.
- Ask for missing boot context before packaging: storage type, boot chain, and target SoC family.
