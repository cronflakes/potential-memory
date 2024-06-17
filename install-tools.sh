#!/bin/bash

SRC="$HOME/src"
BINUTILS_VER="binutils-2.42"
GCC_VER="gcc-14.1.0"
PREFIX="$HOME/opt/cross"
TARGET=i686-elf

mkdir $HOME/$SRC $HOME/$PREFIX/bin


which dnf && dnf -y install gcc gcc-c++ make bison flex gmp-devel \
		    libmpc-devel mpfr-devel texinfo isl-devel wget || exit

#latest version of binutils and gcc (stable/relevant for long time)
cd $SRC/
wget https://ftp.gnu.org/gnu/binutils/${BINUTILS_VER}.tar.xz
wget https://ftp.gnu.org/gnu/gcc/${GCC_VER}/${GCC_VER}.tar.xz

tar -xfJ ${BINUTILS_VER}.tar.xz
tar -xfJ ${GCC_VER}.tar.xz

mkdir build-binutils build-gcc

#binutils
cd build-binutils
../${BINUTILS_VER}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make 
make install

#gcc 
cd ../build-gcc/
../${GCC_VER}/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

export PATH="$HOME/opt/cross/bin:$PATH"




