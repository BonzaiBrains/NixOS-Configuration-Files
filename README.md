# Specs

| Component | Device |
| --- | --- |
| CPU | Intel® Core™ i3-13100F |
| GPU | Intel® Arc™ A750 Limited Edition |
| RAM | 32GB Kingston ValueRAM DDR5-5200 DIMM CL 42 Dual Kit |
| MB | Biostar B760MZ-E Pro (B760,S1700,mATX,Intel) |
| HDD | 4TB Toshiba NAS N300 / 4TB Seagate IronWolf ST4000VN006 |
| SSD | 512GB Crucial P5 Plus / 2TB Kingston NV2 NVMe |
| Case | Chenbro SR20969+ U3 |
| Cpu Cooler | NH-D15 |

# Altered Content

## Table Of Contents

* Kernel
* Filesystems
* User configuration
    * Adrian
* System configuration
* Mutable configuration
* Virtualisation
* Nix configuration

## Kernel

I'm using the latest kernel that is compatible with ZFS, since I want to get the most out of the Intel GPU drivers that are regularly updated. 

## Filesystem

### LVM

I'm using LVM for my two SSDs to pool them.

### ZFS

I'm using ZFS for a software raid 1 on my two HDDs, for the checksums and easy management without a dedicated raid controller. I mostly save ROMs and Qcow images there.

## User configuration

My only user is `adrian`

### Adrian

Who is in the following groups:

* networkmanager 
* wheel


Who has the following packages:

* firefox
* vscode
    * python
    * pylance
    * nix-ide
* pfetch
* pcsx2
* pcsxr
* links2
* glances
* tmux

## System Configuration

Which has the following packages:

* neovim
* qemu
* virt-manager
* pciutils
* git
* lutris
    * wine64
    * winetricks

## Mutable Configuration

Applies to the following packages:

* noisetorch
* dconf
* steam
* bash
    * aliases: `vim, vi = neovim`
* tmux
    * extra configuration: `mouse mode`

## Virtualisation

Libvirtd is enabled for use by Virt-Manager and QEMU

## Nix Configuration

Nix-command and Flakes are enabled along with automatic garbage collection for things older than 31 days.