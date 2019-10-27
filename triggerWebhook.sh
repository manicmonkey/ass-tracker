echo Got arg $1

[[ "$1" == "start" ]] && {
  echo "Sending shift start"
  postData="@webhook_shift_start"
} || {
  echo "Sending shift finish"
  postData="@webhook_shift_finish"
}

curl -v -d "$postData" -H "Content-Type: application/json" -c cookies -X POST http://localhost:3001/webhook
