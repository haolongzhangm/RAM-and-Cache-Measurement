#!/usr/bin/env bash
set -ex

# check NDK_ROOT env variable
if [ -z "$NDK_ROOT" ]; then
    echo "Please set NDK_ROOT environment variable"
    exit 1
else
    echo "use $NDK_ROOT to build for android"
fi

echo "check NDK is invalid or not..."
if [ ! -f "$NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang" ]; then
    echo "NDK_ROOT is invalid"
    exit 1
fi

# build for android
cd $(dirname $0)
rm -rf cache_measure
rm -rf Data.txt

aarch64-linux-android29-clang -O3 -fPIC -Werror -Wall -fno-builtin cache_measure.c -o cache_measure

adb shell mkdir -p /data/local/tmp/
adb push cache_measure /data/local/tmp/
adb shell chmod +x /data/local/tmp/cache_measure
echo "run cache_measure on android, pls wait a moment..., if you want to run a spec cpu core id, pls modify this , for example use taskset"
adb shell "cd /data/local/tmp/ && /data/local/tmp/cache_measure"
adb pull /data/local/tmp/Data.txt

echo "run cache_measure on android done"

echo "now run python plot.py to save the plot as png file"

python3 plt.py

echo "done! result is saved as Data.png in current directory"
