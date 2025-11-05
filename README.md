# Book Template - Obsidian + mdBook + Kindle 本執筆システム

このリポジトリは、Obsidian、mdBook、Pandocを組み合わせた本執筆・出版システムのテンプレートです。フォークして自分の本を書き始めることができます。

## 特徴

- **Obsidian**: アイデア出し、下書き、メモ管理
- **mdBook**: Web形式でのプレビューと確認
- **Pandoc**: Kindle本(EPUB)の生成
- **GitHub**: バージョン管理とバックアップ
- **自動化スクリプト**: 同期やビルドを簡単に実行

## クイックスタート

### 1. このテンプレートを使う

```bash
# GitHubでこのリポジトリをフォーク、または
# テンプレートとして新しいリポジトリを作成

# クローン
git clone https://github.com/your-username/your-book.git
cd your-book
```

### 2. 必要なツールをインストール

#### macOS
```bash
# Rust & mdBook
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install mdbook

# Pandoc
brew install pandoc

# 自動同期用(オプション)
brew install fswatch
```

#### Linux
```bash
# Rust & mdBook
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install mdbook

# Pandoc
sudo apt-get update
sudo apt-get install -y pandoc

# 自動同期用(オプション)
sudo apt-get install -y inotify-tools
```

#### Obsidian
[Obsidian公式サイト](https://obsidian.md/)からダウンロードしてインストール

### 3. 本の情報をカスタマイズ

以下のファイルを編集して、あなたの本の情報に変更してください：

- `book.toml`: mdBookの設定(タイトル、著者名、GitHubリポジトリURL)
- `metadata.yaml`: Kindle本のメタデータ(タイトル、著者、説明文など)
- `README.md`: このファイル(本のREADMEに書き換え)

### 4. Obsidianで執筆を開始

1. Obsidianを起動
2. 「Open folder as vault」を選択
3. このプロジェクトの `obsidian` フォルダを選択
4. `obsidian/drafts/` でアイデア出しや下書き
5. 内容が固まったら `obsidian/published/` に移動
   - ファイル名: `01-chapter-name.md`, `02-another-chapter.md` のように番号を付ける

### 5. mdBookでプレビュー

```bash
# Obsidian → mdBook に同期
bash scripts/sync-to-mdbook.sh

# ローカルサーバー起動
mdbook serve

# ブラウザで http://localhost:3000 を開く
```

### 6. Kindle本(EPUB)の生成

```bash
# EPUBビルド
bash scripts/build-kindle.sh

# 出力: dist/book.epub
```

## ディレクトリ構造

```
.
├── obsidian/               # Obsidian vault(執筆環境)
│   ├── drafts/            # アイデア・下書きエリア
│   │   ├── ideas/         # アイデアメモ
│   │   ├── research/      # リサーチノート
│   │   └── outlines/      # 章の構成案
│   ├── published/         # 本のメイン内容(公開用)
│   │   ├── 00-introduction.md
│   │   ├── 01-chapter-1.md
│   │   ├── 99-conclusion.md
│   │   └── images/        # 画像ファイル
│   └── templates/         # テンプレート
├── src/                   # mdBook用ソースファイル(自動生成)
├── scripts/               # 自動化スクリプト
│   ├── sync-to-mdbook.sh  # Obsidian → mdBook 同期
│   ├── build-kindle.sh    # Kindle本ビルド
│   ├── watch-and-sync.sh  # 自動同期(オプション)
│   └── validate-links.sh  # リンク検証(オプション)
├── styles/                # スタイルシート
│   └── epub.css           # EPUB用CSS
├── dist/                  # 出力ファイル
│   ├── html/              # mdBookのHTML出力
│   └── book.epub          # Kindle用EPUB
├── book.toml              # mdBook設定ファイル
├── metadata.yaml          # Pandoc用メタデータ
├── cover.jpg              # Kindle本の表紙画像(作成してください)
└── README.md              # このファイル
```

## ワークフロー

### 日常的な執筆フロー

1. **Obsidianで執筆**
   - `obsidian/drafts/` でアイデアを自由に書く
   - 内容が固まったら `obsidian/published/` に移動

2. **mdBookで確認**
   ```bash
   bash scripts/sync-to-mdbook.sh
   mdbook serve
   ```

3. **自動同期を使う場合(オプション)**
   ```bash
   # ターミナル1: 自動同期
   bash scripts/watch-and-sync.sh

   # ターミナル2: mdBookサーバー
   mdbook serve
   ```

4. **Gitでバージョン管理**
   ```bash
   git add obsidian/published/*.md
   git commit -m "執筆: 第2章の初稿完成"
   git push
   ```

### Kindle本の出版準備

1. **ビルド前チェック**
   - [ ] 全章の執筆が完了
   - [ ] 誤字脱字チェック完了
   - [ ] 画像が正しく表示されるか確認
   - [ ] metadata.yaml の情報が正確か確認
   - [ ] cover.jpg が用意されているか確認

2. **EPUBの生成**
   ```bash
   bash scripts/build-kindle.sh
   ```

3. **プレビュー**
   - [Kindle Previewer](https://kdp.amazon.co.jp/ja_JP/help/topic/G202131170)でプレビュー

4. **出版**
   - [Kindle Direct Publishing (KDP)](https://kdp.amazon.co.jp/)にアップロード

## 便利なスクリプト

```bash
# Obsidian → mdBook 同期
bash scripts/sync-to-mdbook.sh

# Kindle本ビルド
bash scripts/build-kindle.sh

# 自動同期(ファイル変更を監視)
bash scripts/watch-and-sync.sh

# リンク検証
bash scripts/validate-links.sh
```

## Obsidianテンプレートの使い方

1. Obsidian設定 → Core plugins → "Templates" を有効化
2. Templates folder location を `templates` に設定
3. 新しいノートで、テンプレートを挿入(Ctrl/Cmd + P → "Insert template")

利用可能なテンプレート：
- `chapter-template.md`: 章の執筆用
- `idea-template.md`: アイデアメモ用
- `research-template.md`: リサーチノート用

## GitHub Actions(自動ビルド)

このテンプレートには、GitHub Actionsの設定ファイルが含まれています。

- `main` ブランチへのプッシュで自動的にmdBookとEPUBをビルド
- GitHub Pagesに自動デプロイ(mdBook)
- EPUBはArtifactとしてダウンロード可能
- タグ(例: `v1.0.0`)をプッシュすると、Releaseが作成される

## トラブルシューティング

### mdBookが起動しない
```bash
mdbook --version
cargo install mdbook --force
```

### 同期スクリプトが動作しない
```bash
chmod +x scripts/*.sh
bash -x scripts/sync-to-mdbook.sh
```

### 画像がEPUBで表示されない
- 画像パスは相対パスを使用: `![説明](images/figure.png)`
- 絶対パスは使わない: `![説明](/images/figure.png)` ❌

## 詳細なガイド

詳細な使い方や高度な活用方法については、`GUIDE.md` を参照してください。

## 参考リソース

- [mdBook Documentation](https://rust-lang.github.io/mdBook/)
- [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
- [Obsidian Help](https://help.obsidian.md/)
- [Kindle Direct Publishing (KDP)](https://kdp.amazon.co.jp/)

## ライセンス

このテンプレートは自由に使用・改変できます。あなたの本の執筆にお役立てください！

---

**Happy Writing! 📚✨**
