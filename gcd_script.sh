# 引数の数をチェック
if [ "$#" -ne 2 ]; then
  echo "ERROR: 引数には2つの自然数を指定してください。" >&2
    exit 1
fi

# 引数が自然数かどうかをチェック
if ! [[ "$1" =~ ^[1-9][0-9]*$ ]] || ! [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
  echo "ERROR: 引数には自然数を指定してください。" >&2
    exit 1
fi

# 最大公約数を計算する関数
function gcd() {
  local a=$1
    local b=$2
    
  while [ "$b" -ne 0 ]; do
    local remainder=$((a % b))
    a=$b
    b=$remainder
  done
  
  echo "$a"
}

# 最大公約数を計算して出力
result=$(gcd "$1" "$2")
echo "最大公約数: $result"

