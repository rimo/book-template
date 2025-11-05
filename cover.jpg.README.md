# 表紙画像について

Kindle本を出版する際は、`cover.jpg` という名前で表紙画像をこの場所に配置してください。

## 推奨仕様

- **ファイル名**: `cover.jpg` または `cover.png`
- **サイズ**:
  - 推奨: 2560 x 1600 ピクセル (縦横比 1.6:1)
  - 最小: 1000 x 625 ピクセル
  - 最大: 10,000 x 10,000 ピクセル
- **ファイルサイズ**: 50MB以下 (推奨: 5MB以下)
- **ファイル形式**: JPEG (.jpg) または PNG (.png)

## Kindle Direct Publishing (KDP) の要件

詳細は[KDP 表紙ガイドライン](https://kdp.amazon.co.jp/ja_JP/help/topic/G200645690)を参照してください。

## 表紙がない場合

表紙画像がない状態でも `build-kindle.sh` スクリプトは実行できます。その場合、警告メッセージが表示されますが、EPUBは生成されます（表紙なし）。

## 表紙作成ツール

- [Canva](https://www.canva.com/) - オンライン デザインツール
- [GIMP](https://www.gimp.org/) - 無料の画像編集ソフト
- [Adobe Photoshop](https://www.adobe.com/products/photoshop.html) - プロフェッショナル向け
- [Kindle Cover Creator](https://kdp.amazon.co.jp/ja_JP/cover-templates) - Amazon公式ツール
