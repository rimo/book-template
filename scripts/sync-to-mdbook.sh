#!/bin/bash

# Obsidian → mdBook 同期スクリプト
# 使い方: bash scripts/sync-to-mdbook.sh

set -e  # エラーが発生したら停止

echo "========================================="
echo "Obsidian → mdBook 同期開始"
echo "========================================="

# ディレクトリの存在確認
if [ ! -d "obsidian/published" ]; then
    echo "エラー: obsidian/published ディレクトリが見つかりません"
    exit 1
fi

# src ディレクトリの作成(存在しない場合)
mkdir -p src

# ObsidianのpublishedフォルダからmdBookのsrcへ同期
echo "ファイルを同期中..."
rsync -av --delete \
  --exclude='.obsidian' \
  --exclude='.DS_Store' \
  --exclude='*.swp' \
  obsidian/published/ \
  src/

# YAMLフロントマターを除去
echo "YAMLフロントマターを除去中..."
for file in src/[0-9][0-9]-*.md; do
  if [ -f "$file" ]; then
    # YAMLフロントマター(最初の---から次の---まで)を削除
    awk '
      BEGIN { in_frontmatter=0; past_frontmatter=0 }
      /^---$/ {
        if (!past_frontmatter) {
          in_frontmatter = !in_frontmatter
          if (!in_frontmatter) past_frontmatter=1
          next
        }
      }
      !in_frontmatter { print }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  fi
done

# SUMMARY.mdの自動生成
echo "SUMMARY.md を生成中..."

cat > src/SUMMARY.md << 'EOF'
# Summary

[はじめに](./00-introduction.md)

# 本編

EOF

# published内の章ファイルを順番に追加(00-introduction と 99-conclusion 以外)
for file in obsidian/published/[0-9][0-9]-*.md; do
  if [ -f "$file" ]; then
    basename=$(basename "$file")

    # はじめにと結論はスキップ
    if [[ "$basename" == "00-introduction.md" ]] || [[ "$basename" == "99-conclusion.md" ]]; then
      continue
    fi

    # Markdownの最初の見出し(# で始まる行)をタイトルとして抽出
    title=$(grep -m 1 '^# ' "$file" | sed 's/^# //' | sed 's/\[.*\]//')

    # タイトルが取得できない場合はファイル名を使用
    if [ -z "$title" ]; then
      title=$(echo "$basename" | sed 's/^[0-9][0-9]-//' | sed 's/.md$//' | sed 's/-/ /g')
    fi

    echo "- [$title](./$basename)" >> src/SUMMARY.md
  fi
done

# 結論を追加
if [ -f "obsidian/published/99-conclusion.md" ]; then
  echo "" >> src/SUMMARY.md
  echo "---" >> src/SUMMARY.md
  echo "" >> src/SUMMARY.md
  title=$(grep -m 1 '^# ' "obsidian/published/99-conclusion.md" | sed 's/^# //')
  if [ -z "$title" ]; then
    title="おわりに"
  fi
  echo "- [$title](./99-conclusion.md)" >> src/SUMMARY.md
fi

echo ""
echo "✅ 同期完了"
echo "同期されたファイル数: $(find src -name "*.md" ! -name "SUMMARY.md" | wc -l)"
echo ""
echo "mdBookでプレビューするには:"
echo "  mdbook serve"
echo ""
