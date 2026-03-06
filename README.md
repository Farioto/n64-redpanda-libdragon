# N64 Panda Demo #

A tiny Nintendo 64 homebrew project that displays a full‑screen panda image using [**libdragon**](https://github.com/DragonMinded/libdragon).
This project is based on ideas from [Dillonb's n64-redpanda](https://github.com/Dillonb/n64-redpanda) and examples found in libdragon’s documentation.

This is a work in progress.

It uses:

- **MSYS2 UCRT64** environment  
- **ImageMagick** for JPG → PNG conversion  
- **libdragon (preview branch)**  
- **gcc-toolchain-mips64-win64-preview**  
- A simple Makefile that converts assets and builds a ROM

---

## 📦 1. Install MSYS2 (UCRT64)

Download MSYS2 from:  
https://www.msys2.org/

Open the **ucrt64** shell:

MSYS2 UCRT64

Install required packages:

```bash
pacman -Syu
pacman -S git make cmake python pkgconf \
          mingw-w64-ucrt-x86_64-gcc \
          mingw-w64-ucrt-x86_64-imagemagick

Note:  
We install the UCRT64 version of ImageMagick because the project is built inside the UCRT environment.

Install ImageMagick (UCRT64)
If you didn’t install it above:

pacman -S mingw-w64-ucrt-x86_64-imagemagick

You can verify it works:

magick -version

🛠️ 3. Install the libdragon toolchain
Download the gcc-toolchain-mips64-win64-preview ZIP from the libdragon releases page.

Extract it somewhere permanent.
In this example:

/z/Tools/libdragon/V14.2.0-17896385267/gcc-toolchain-mips64-win64-preview

Inside that folder you should see:

bin/
include/
lib/
libexec/
mips64-elf/
share/

🌱 4. Set the N64_INST environment variable
This tells libdragon where the toolchain lives.

Temporary (per shell):

export N64_INST="/z/Tools/libdragon/V14.2.0-17896385267/gcc-toolchain-mips64-win64-preview"

Permanent (UCRT64)
Edit:

~/.bash_profile

Add:

export N64_INST="/z/Tools/libdragon/V14.2.0-17896385267/gcc-toolchain-mips64-win64-preview"

Reload:

source ~/.bash_profile

🐉 5. Clone libdragon (preview branch)
Choose a location for your source tree.
Example:

/z/source/libdragon-preview

Clone:

git clone --recursive https://github.com/DragonMinded/libdragon.git libdragon-preview
cd libdragon-preview
git checkout preview

🔧 6. Build and install libdragon
Build tools:

cd tools
make all
make install
cd ..

Build libdragon itself:

make all
make install

Build examples (optional):

make examples

If everything is set correctly, the examples will compile and run in an emulator.

🔄 7. Updating libdragon (preview)
To update:
cd /z/source/libdragon-preview
git pull
make clean
cd tools
make clean
make all
make install
cd ..
make all
make install

🐉 8. Using the main branch instead
Repeat the same steps, but:

Clone without git checkout preview

Use the non-preview toolchain folder

Build normally

🐼 9. Building this project
Once libdragon is installed cd into this project directory and then run

make

This will:

Convert assets/panda.jpg → build/assets/panda.png

Convert PNG → filesystem/panda.sprite

Build the ROM: panda.z64

Run it in an emulator or on real hardware.











