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

read -p "ada pesan? : " pesan
curl -F name=text -F text="$pesan"   -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendMessage?chat_id=-1001850488353"


#ubah nama kernel dan dev builder
export ARCH=arm64
export KBUILD_BUILD_USER=ucipp
export LOCALVERSION=-liquwit-kernel-atom
#mulai mengcompile kernel
curl -F name=text -F text="memulai build"   -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendMessage?chat_id=-1001850488353"
curl -F name=text -F text="moga ga eror"  -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendMessage?chat_id=-1001850488353"
make O=out ARCH=arm64 even_defconfig

PATH="/workspace/compler/bin:$PATH" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="clang" \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE="aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="arm-linux-gnueabihf-" \
                      CONFIG_NO_ERROR_ON_MISMATCH=y \
V=0 2>&1  | tee log.log

echo ziping
cd AnyKernel3
rm liquwidkrenel.zip
cp -r ../out/arch/arm64/boot/Image.gz-dtb ../AnyKernel3
zip -r9 liquwidkrenel.zip * -x .git README.md *placeholder
rm -rf ../liquwidkrenel.zip
cp -r liquwidkrenel.zip ../
cd ..


curl -F name=document -F document=@"liquwidkrenel.zip" -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendDocument?chat_id=-1001850488353"
if [ $? -eq 26 ]
then
curl -F name=text -F text="build gagal jadi ini log nya aja yang nonggol🗿"   -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendMessage?chat_id=-1001850488353"
exit 26
fi

curl -F name=document -F document=@"log.log" -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendDocument?chat_id=-1001850488353"



echo Done selemek selentod!
