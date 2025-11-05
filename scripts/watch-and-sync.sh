#!/bin/bash

# ファイル変更を監視して自動同期
# 使い方: bash scripts/watch-and-sync.sh

echo "========================================="
echo "自動同期モード起動"
echo "obsidian/published を監視中..."
echo "Ctrl+C で終了"
echo "========================================="

# macOS の場合
if command -v fswatch &> /dev/null; then
    fswatch -o obsidian/published | while read num; do
        echo ""
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 変更を検知。同期を開始..."
        bash scripts/sync-to-mdbook.sh
    done

# Linux の場合
elif command -v inotifywait &> /dev/null; then
    while inotifywait -r -e modify,create,delete,move obsidian/published; do
        echo ""
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 変更を検知。同期を開始..."
        bash scripts/sync-to-mdbook.sh
    done

else
    echo "エラー: fswatch (macOS) または inotifywait (Linux) がインストールされていません"
    echo ""
    echo "インストール方法:"
    echo "  macOS: brew install fswatch"
    echo "  Linux: sudo apt-get install inotify-tools"
    exit 1
fi
