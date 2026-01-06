# Repository Guidelines

## プロジェクト構成・モジュール配置
- `init.lua` は Lazy.nvim をブートストラップし、主要設定を読み込みます。
- `lua/lazy_setup.lua` は AstroNvim とプラグイン定義（Lazy spec）をまとめます。
- `lua/plugins/` はプラグイン単位の追加・上書きを配置します。
- `lua/community.lua` は AstroCommunity の読み込み用（デフォルト無効）。
- `lua/polish.lua` は最後に実行される追加設定（デフォルト無効）。
- `selene.toml` と `neovim.yml` は Selene の Lua lint 設定です。

## ビルド・テスト・開発コマンド
- `nvim` — Neovim を起動し、初回は AstroNvim/Lazy がプラグイン管理を行います。
- Neovim 内で `:Lazy sync` — プラグインの同期・更新を実行します。

このリポジトリは Neovim 設定であり、専用のビルド工程はありません。

## コーディングスタイル・命名規則
- Lua のインデントは 2 スペース（既存ファイルに合わせる）。
- ファイル名とモジュール名を揃える（例: `lua/plugins/treesitter.lua`）。
- Selene で lint（`selene.toml` 参照）。
- StyLua は設定内コメントと Mason で言及あり。導入済みなら整形に使用。

## テスト方針
- 自動テストはありません。
- 変更後は `nvim` を起動し、起動エラーやプラグイン動作を確認します。
- LSP/formatter 変更時は `:LspInfo` と Lua ファイルの整形確認を推奨します。

## コミット・PR ガイドライン
- コミットメッセージは Conventional Commits 形式（例: `feat: add plugin`, `fix: adjust LSP config`）。
- PR には概要、影響箇所（パス）、検証手順（Neovim コマンド等）を記載。
- UI やキーマップ変更はスクリーンショットか簡単な使用説明を添付。

## 設定に関する補足
- デフォルトで無効化されているファイルがあります。
  - `lua/community.lua`: `if true then return {} end`
  - `lua/plugins/*.lua`: `if true then return {} end`
  - `lua/polish.lua`: `if true then return end`
- 有効化するにはガードを削除/反転し、` :Lazy sync` を実行します。
