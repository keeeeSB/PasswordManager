#!/bin/bash

DATA_FILE="passwords.txt"
ENCRYPTED_FILE="passwords.txt.gpg"

echo "パスワードマネージャーへようこそ！"

while true; do
  echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  read -r choice

  case "$choice" in

    "Add Password")

      if [ -f "$ENCRYPTED_FILE" ]; then
        gpg "$ENCRYPTED_FILE"
      fi

      echo "サービス名を入力してください："
      read -r service
      echo "ユーザー名を入力してください："
      read -r username
      echo "パスワードを入力してください："
      read -r password

      echo "${service}:${username}:${password}" >> "$DATA_FILE"

      gpg -c "$DATA_FILE"

      rm "$DATA_FILE"

      echo "パスワードの追加は成功しました。"
      ;;

    "Get Password")
      echo "サービス名を入力してください："
      read -r service

      gpg "$ENCRYPTED_FILE"

      result=$(grep "^${service}:" "$DATA_FILE")

      if [ -z "$result" ]; then
        echo "そのサービスは登録されていません。"
      else
        IFS=":" read -r found_service found_user found_pass <<< "$result"
        echo "サービス名：$found_service"
        echo "ユーザー名：$found_user"
        echo "パスワード：$found_pass"
      fi

      rm "$DATA_FILE"
      ;;

    "Exit")
      echo "Thank you!"
      exit 0
      ;;

    *)
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      ;;
  esac

done

