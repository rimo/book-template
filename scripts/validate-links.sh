#!/bin/bash

# Markdown内のリンクを検証
# 使い方: bash scripts/validate-links.sh

echo "========================================="
echo "リンク検証開始"
echo "========================================="

ERRORS=0

# obsidian/published 内の全.mdファイルをチェック
for file in obsidian/published/*.md; do
    if [ -f "$file" ]; then
        # [[ファイル名]] 形式のWikilink検証
        while IFS= read -r link; do
            # .md拡張子を追加して検索
            if [ ! -f "obsidian/published/${link}.md" ] && [ ! -f "obsidian/drafts/${link}.md" ]; then
                echo "❌ 壊れたリンク: $file -> [[${link}]]"
                ERRORS=$((ERRORS + 1))
            fi
        done < <(grep -o '\[\[\([^]]*\)\]\]' "$file" | sed 's/\[\[\(.*\)\]\]/\1/')

        # 画像リンクの検証
        while IFS= read -r image; do
            if [ ! -f "obsidian/published/images/${image}" ]; then
                echo "❌ 画像が見つかりません: $file -> $image"
                ERRORS=$((ERRORS + 1))
            fi
        done < <(grep -o '!\[.*\](\(images/[^)]*\))' "$file" | sed 's/.*(\(.*\))/\1/')
    fi
done

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ リンク検証完了: エラーなし"
else
    echo "⚠️  リンク検証完了: ${ERRORS}個のエラーが見つかりました"
fi
echo ""
