read -p "tulis pesan : " pesan
curl -F name=text -F text="$pesan"   -H "Content-Type:multipart/form-data" "https://api.telegram.org/bot5879794084:AAEtYbuY5NylDuNYK4WL0oVFoDaboVt7Z3g/sendMessage?chat_id=-1001850488353"
bash gruptele.sh