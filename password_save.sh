echo "パスワードマネージャーへようこそ！"

echo "サービス名を入力してください："
read servise

echo "ユーザー名を入力してください："
read username

echo "パスワードを入力してください："
read password

FILE="passwords.txt"

echo "${service}:${username}:${password}" >> $FILE

echo "Thank you!"
