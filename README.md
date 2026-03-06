# N64 Panda Demo

This is a preview image of what you will see when you run the ROM:

<img src="./assets/panda.jpg" width="640">

---

## Purpose
- A tiny Nintendo 64 homebrew project that displays a full-screen panda image using libdragon.
- Rewritten entirely using the libdragon engine and a simple asset pipeline.
- This project is based on Dillonb's N64 Panda Demo which uses assembly:
  https://github.com/Dillonb/n64-redpanda
- Also based on examples found in libdragon’s documentation:
  https://github.com/DragonMinded/libdragon

---

## Requirements
- MSYS2 (UCRT64 environment)
- ImageMagick (UCRT64 build)
- libdragon (preview branch)
- gcc-toolchain-mips64-win64-preview
- A Makefile that converts assets and builds the ROM

---

## Install MSYS2 (UCRT64)

Download MSYS2 from:
https://www.msys2.org/

Open the UCRT64 shell.

Install required packages:

```bash
pacman -Syu
pacman -S git make cmake python pkgconf \
          mingw-w64-ucrt-x86_64-gcc \
          mingw-w64-ucrt-x86_64-imagemagick
```

Note:
We install the UCRT64 version of ImageMagick because the project is built inside the UCRT environment.

Install ImageMagick (UCRT64) if you didn’t install it above:

```bash
pacman -S mingw-w64-ucrt-x86_64-imagemagick
```

Verify ImageMagick:

&#96;&#96;&#96;bash
magick -version
&#96;&#96;&#96;

---

## Install the libdragon toolchain

Download the **gcc-toolchain-mips64-win64** ZIP from the libdragon releases page:

https://github.com/DragonMinded/libdragon/releases/tag/toolchain-continuous-prerelease

Extract it somewhere permanent.

The extracted folder is normally named:

gcc-toolchain-mips64-win64

To avoid interfering with an existing main-branch toolchain, rename it or extract as:

gcc-toolchain-mips64-win64-preview

Example final path:

/c/Tools/libdragon/gcc-toolchain-mips64-win64-preview

Inside that folder you should see:

- bin/
- include/
- lib/
- libexec/
- mips64-elf/
- share/

---

## Set the N64_INST environment variable

Temporary (per shell):

```bash
export N64_INST="/c/Tools/libdragon/gcc-toolchain-mips64-win64-preview"
```

Permanent (UCRT64):

Edit:

~/.bash_profile

Add:

```bash
export N64_INST="/c/Tools/libdragon/gcc-toolchain-mips64-win64-preview"
```

Reload:

```bash
source ~/.bash_profile
```

---

## Clone libdragon (preview branch)

Choose a location for your source tree. Example:

/c/source/libdragon-preview

Clone:

```bash
git clone --recursive https://github.com/DragonMinded/libdragon.git libdragon-preview
cd libdragon-preview
git checkout preview
```

---

## Build and install libdragon

Build tools:

```bash
cd tools
make all
make install
cd ..
```

Build libdragon itself:

```bash
make all
make install
```

Build examples (optional):

```bash
make examples
```

If everything is set correctly, the examples will compile and run in an emulator.

---

## Updating libdragon (preview)

To update:

```bash
cd /c/source/libdragon-preview
git pull
make clean
cd tools
make clean
make all
make install
cd ..
make all
make install
```

---

## Using the main branch instead

Repeat the same steps, but:

- Clone without `git checkout preview`
- Use the non-preview toolchain folder
- Build normally

---

## Building this project

Once libdragon is installed, cd into this project directory and then run:

```bash
make
```

This will:

- Convert assets/panda.jpg -> build/assets/panda.png
- Convert PNG -> filesystem/panda.sprite
- Build the ROM: panda.z64

Run it in an emulator or on real hardware.
