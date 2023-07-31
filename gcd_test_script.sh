#!/bin/bash

# 最大公約数シェルスクリプトのパスを設定
gcd_script_path="./gcd_script.sh"

# ヘルパー関数: エラーメッセージを出力して異常終了
function print_error_and_exit() {
  echo "エラー: $1" >&2
  exit 1
}

# テスト関数: 想定した挙動を確認
function run_test() {
  local input="$1"
  local expected_output="$2"
  local result

  # 最大公約数シェルスクリプトを実行して結果を取得
  result="$("$gcd_script_path" $input | grep -o '[0-9]*')"

  # エラー終了の場合
  if [[ "$expected_output" = "ERROR"* ]]; then
    if [[ -z "$result" ]]; then
      echo "テスト成功: 入力 $input => 出力 $expected_output"
    else
      print_error_and_exit "テスト失敗: 入力 $input => 期待される出力 \"$expected_output\", 実際の出力 最大公約数: $result"
    fi
  # 正常終了の場合
  else
    if [[ "$result" -eq "$expected_output" ]]; then
      echo "テスト成功: 入力 $input => 出力 最大公約数: $result"
    else
      print_error_and_exit "テスト失敗: 入力 $input => 期待される出力 最大公約数: \"$expected_output\", 実際の出力 最大公約数: $result"
    fi
  fi
}

# テストケースを実行
echo "==== テスト開始 ===="

# 正常なテストケース
run_test "2 4" 2
run_test "3 6" 3
run_test "20 30" 10
run_test "1 1" 1
run_test "1000 1000" 1000

# エラーメッセージを期待するテストケース
run_test "3" "ERROR: 引数には2つの自然数を指定してください。"
run_test "hello world" "ERROR: 引数には2つの自然数を指定してください。"
run_test "0 5" "ERROR: 引数には2つの自然数を指定してください。"
run_test "1 2 3" "ERROR: 引数には2つの自然数を指定してください。"
run_test "2 -4" "ERROR: 引数には自然数を指定してください。"
run_test "1.5 2.3" "ERROR: 引数には自然数を指定してください。"

echo "==== テスト終了 ===="

