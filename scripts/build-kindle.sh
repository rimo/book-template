#!/bin/bash

# Kindle本ビルドスクリプト
# 使い方: bash scripts/build-kindle.sh

set -e

echo "========================================="
echo "Kindle本(EPUB)ビルド開始"
echo "========================================="

# 必要なファイルの確認
if [ ! -f "metadata.yaml" ]; then
    echo "エラー: metadata.yaml が見つかりません"
    exit 1
fi

if [ ! -f "cover.jpg" ]; then
    echo "警告: cover.jpg が見つかりません。表紙なしでビルドします。"
    COVER_OPTION=""
else
    COVER_OPTION="--epub-cover-image=cover.jpg"
fi

# 出力ディレクトリの作成
mkdir -p dist

# Obsidian published フォルダから章ファイルを取得(番号順)
echo "章ファイルを収集中..."
FILES=$(find obsidian/published -name "[0-9][0-9]-*.md" | sort)

if [ -z "$FILES" ]; then
    echo "エラー: 章ファイルが見つかりません"
    exit 1
fi

echo "見つかった章:"
echo "$FILES"
echo ""

# Pandocでビルド
echo "EPUBを生成中..."
pandoc -o dist/book.epub \
  --from=markdown+smart \
  --to=epub3 \
  metadata.yaml \
  $FILES \
  --toc \
  --toc-depth=3 \
  $COVER_OPTION \
  --epub-metadata=metadata.yaml \
  --css=styles/epub.css \
  --highlight-style=tango \
  --resource-path=.:obsidian/published

echo ""
echo "✅ ビルド完了"
echo "出力ファイル: dist/book.epub"
echo ""

# ファイルサイズ表示
if [ -f "dist/book.epub" ]; then
    SIZE=$(du -h dist/book.epub | cut -f1)
    echo "ファイルサイズ: $SIZE"
    echo ""
    echo "次のステップ:"
    echo "1. Kindle Previewer で確認"
    echo "2. Kindle Direct Publishing (KDP) にアップロード"
    echo ""
fi
