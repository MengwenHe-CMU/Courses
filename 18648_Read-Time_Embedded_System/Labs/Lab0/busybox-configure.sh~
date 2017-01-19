#!/bin/bash
NDK=$HOME/SDK/android-ndk-r9
NDK_TC=arm-linux-androideabi-4.8 NDK_API=android-14 NDK_GCC=4.8
SYSROOT=$NDK/platforms/$NDK_API/arch-arm
LIBSTDCPP=$NDK/sources/cxx-stl/gnu-libstdc++
INCLUDES="-isystem $SYSROOT/usr/include -isystem $LIBSTDCPP/include "\
"-isystem $LIBSTDCPP/$NDK_GCC/include "\
"-isystem $LIBSTDCPP/$NDK_GCC/include/backward "\
"-isystem $LIBSTDCPP/$NDK_GCC/libs/armeabi-v7a/include"

declare -A vars
vars[CROSS_COMPILER_PREFIX]=arm-linux-androideabi-
vars[SYSROOT]=$SYSROOT
vars[EXTRA_LDFLAGS]="-rdynamic --sysroot $SYSROOT -Wl,--gc-sections "\
"-L$LIBSTDCPP/$NDK_GCC/libs/armeabi-v7a -lgnustl_static -lsupc++"
vars[EXTRA_CFLAGS]="-fsigned-char -march=armv7-a -mfloat-abi=softfp "\
"-mfpu=vfp -fdata-sections -ffunction-sections -fexceptions -mthumb "\
"-fPIC -Wno-psabi -DANDROID -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ "\
"-D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__ -fomit-frame-pointer "\
"--sysroot $SYSROOT $INCLUDES"

for var in CROSS_COMPILER_PREFIX SYSROOT EXTRA_LDFLAGS EXTRA_CFLAGS
do
    sed -i "s|^CONFIG_$var=.*|CONFIG_$var=\"${vars[$var]}\"|" .config
done

export PATH=$NDK:$NDK/toolchains/$NDK_TC/prebuilt/linux-x86_64/bin:$PATH
