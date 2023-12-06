
#membersihkan
sleep 2
echo sabar lagi persiapan
rm -rf out
sleep 1
make mrproper
sleep 5
echo persiapan selesai
sleep 1
echo .
sleep 1
echo .
echo .
sleep 1
echo membuild kernel.......
sleep 2

#ubah nama kernel dan dev builder
export ARCH=arm64
export KBUILD_BUILD_USER=yusup
export LOCALVERSION=-liquwid-kernel
#mulai mengcompile kernel

make O=out ARCH=arm64 even_defconfig

PATH="clang/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="clang" \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE="aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="arm-linux-gnueabihf-" \
                      CONFIG_NO_ERROR_ON_MISMATCH=y \
V=0 2>&1 | tee log.txt

echo ziping
cd anykernel3
rm liquwidkrenel.zip
cp -r ../out/arch/arm64/boot/Image.gz-dtb ../anykernel3
zip -r9 liquwidkrenel.zip * -x .git README.md *placeholder
cd ..

echo Done selemek selentod!

