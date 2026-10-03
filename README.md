# Mac の設定を復元する dotfiles

Apple Silicon Mac 向け。zsh、Git、Alacritty、Starship、tmux、Neovim、mise、Karabiner-Elements の設定を管理します。Dock/Finder/キーリピートなど、選択したmacOS設定も保存しています。

詳しい操作は [このMac専用マニュアル](docs/mac-manual.md) を参照してください。

## 新しいMacに復元する

1. Xcode Command Line Tools (`xcode-select --install`) と [Homebrew](https://brew.sh/) を導入します。GitHubの認証が必要な場合は本人のアカウントで行います。
2. リポジトリを取得し、適用予定を確認します。

```sh
git clone https://github.com/vannamei/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

3. 設定と開発ツールを適用します。

```sh
./install.sh --apply --tools
```

既存の設定は `~/.local/state/dotfiles-backups/日時-PID/` に退避し、リポジトリへのシンボリックリンクに置き換えます。同じ設定へ再適用しても退避を繰り返しません。ツールを入れ直さず設定だけを適用する場合は `./install.sh --apply` を使います。

4. 新しいターミナルで `nvim` を開き、初回のプラグイン・言語サーバー取得が終わるまで待ちます。`:Lazy` / `:Mason` で確認し、必要なら `:Lazy restore` で `lazy-lock.json` の版へ戻します。
5. Karabiner-Elementsを開き、macOSが要求する入力監視・システム拡張などを本人が許可します。保存した設定には内蔵キーボードの Caps Lock → 左Control と、既存の日本語入力切り替えが含まれます。外付けキーボードは機種に応じて確認してください。

追加アプリは任意です。

```sh
brew bundle install --no-upgrade --file=Brewfile.apps
```

DockやFinderなどの設定も戻す場合は、内容を確認して適用します。アプリの強制終了は行いません。

```sh
python3 scripts/macos.py
python3 scripts/macos.py --apply
```

## 日常的に保存する

```sh
cd ~/dotfiles
./scripts/save.sh
# Dock/Finderなども更新した場合だけ:
python3 scripts/macos.py --capture
git status --short
git diff
git add .
git commit -m "Update Mac settings"
git push origin main
```

シンボリックリンクになっている設定は編集がそのままGitに現れます。Karabinerやmiseが別ファイルのままの場合は `snapshot.py` が取り込みます。snapshotはその時点のmise設定も保存するので、`latest`などを使っている場合は、版を固定したいかをコミット前に確認してください。

Brewfileは導入するツールの宣言です。追加・削除したパッケージは該当するBrewfileを編集してください。依存ライブラリの一括列挙や、`brew bundle cleanup --force`による削除は行いません。

## 過去の設定へ戻す

```sh
git log --oneline
# 指定コミットの設定を作業ツリーへ復元する（<commit>は実際のIDに置換）
git restore --source=<commit> -- .zshrc .zprofile .tmux.conf .config Brewfile Brewfile.apps manifests
# 差分を確認し、復元を新しい履歴として保存する
git diff
git add .
git commit -m "Restore previous Mac settings"
git push origin main
./install.sh --apply
```

既存の未コミット変更がある場合は先に別コミットまたはバックアップへ保存してください。Neovimを終了してから設定を戻し、再起動後に `:Lazy restore` を実行します。macOS設定は `scripts/macos.py --apply` で別途反映します。履歴の強制書き換えやforce-pushは不要です。

## 保存範囲と注意点

- `.config/nvim/lazy-lock.json` でプラグインの取得コミットを記録。
- mise設定には棚卸し時の言語バージョンを指定。`manifests/tool-versions.toml` にも参照用の実バージョンを保存。
- Homebrewは当時のバイナリを完全固定する仕組みではありません。`--no-upgrade`は既存パッケージの更新を避ける指定で、新しいMacではその時点で取得可能な版が入ります。
- `manifests/python-global.txt` と `node-global.txt` は旧グローバル環境の記録。新Neovimに必須ではないため自動再インストールしません。
- OS本体、写真・文書、アプリの内部データ、パスワード、SSH鍵、APIトークン、ブラウザのログイン、macOSの権限は含みません。これらのデータ保護には別途バックアップが必要です。
- このリポジトリは公開です。認証情報・履歴・端末固有の秘密を入れないでください。`.gitignore`は補助であり、コミット前に差分を確認します。
- Alacrittyの使用テーマを通常のファイルとして同梱し、取得不能だったGit参照を解消しています。テーマのライセンスは同じフォルダのLICENSEを参照してください。

## 主なNeovim操作

Spaceがleaderです。Space e: ファイル一覧、Space Space: 検索、Space /: 全文検索、Space f s: 保存、Space c f: 整形、gd: 定義、K: 説明。保存時の自動整形は無効です。

## 検証

`mise exec python -- python3 -m unittest discover -s tests` で一時ホームへの適用、既存ファイルの退避、二重適用、欠損ソース時の停止、Homebrew失敗時の保全、snapshotの競合検出を検証します。実際のホームには適用しません。

## 2026-09-28 の修正

- `.tmux.conf` を追跡し、新しいMacでもtmuxが既定の場所から設定を読み込めるようにしました。
- tmuxのプレフィックスは Ctrl-b。Ctrl-j はNeovimの分割移動に使えます。設定再読み込みは Ctrl-b → r。
- zshのFLOW_CONTROLとTTYのIXONを無効にして、Ctrl-sが出力停止にならないようにしました。新しいターミナルで有効になります。
- miseの実環境と保存内容を固定バージョンに統一し、追加されたCodex CLIも記録しました。
- Time Machineのディスク指定・初回バックアップは別途必要です。保存先が決まっていない状態でディスク消去や登録を行うことはありません。

## 保存漏れの確認と個人情報

- `./scripts/save.sh --check` はmise/Karabinerの実設定とGit側を比較します。一致なら終了コード0、不一致や欠損なら1です。変更は行いません。
- `./scripts/save.sh` は取り込みと差分一覧の表示をまとめます。Git側にも別の編集があれば上書きせず停止するので、先に両方の内容を統合します。取り込み前の内容は `.git/dotfiles-snapshots/` に退避します。
- `lazyvim.json` もGit管理するため、`:LazyExtras`で選択した機能を復元できます。変更後は通常のcommit/pushが必要です。
- Gitの名前・メールは `~/.gitconfig.local` に分離します。新しいMacでは `.gitconfig.local.example` を参考に、本人の情報を入力してください。これはGitへ追加しません。
- 公開コミットのメールアドレスを隠す場合は、GitHubのメール設定画面に表示されるnoreplyアドレスを使います。過去のコミットや過去の設定履歴はそのまま残ります。
- `--apply --tools` はHomebrewの確認とパッケージ取得を設定の置き換えより先に行います。Homebrew自身が途中まで導入したパッケージは自動削除しません。miseの取得は設定適用後のため、通信などで失敗した場合は原因を解消して再実行してください。
