# このMacの操作・復元マニュアル

**vannamei専用｜2026年10月3日版**

対象：macOS 26.2（25C56）・Apple Silicon（arm64）

設定基準：2026年10月3日の保存・復元改善（元の操作設定：`ea680f6`）

保存先：[GitHub — vannamei/dotfiles](https://github.com/vannamei/dotfiles)

このMacの実ファイルと、インストール済みLazyVimのキーマップを確認して作成しました。操作例は内蔵キーボードを基本にしています。設定を変更した後は、このマニュアルも更新してください。

## 目次

1. [まず覚える操作](#1-まず覚える操作)
2. [このMacの構成](#2-このmacの構成)
3. [キーボードと日本語入力](#3-キーボードと日本語入力)
4. [ターミナルの基本](#4-ターミナルの基本)
5. [Neovimの使い方](#5-neovimの使い方)
6. [tmuxの使い方](#6-tmuxの使い方)
7. [ツールと言語の管理](#7-ツールと言語の管理)
8. [設定を変更してGitHubへ保存](#8-設定を変更してgithubへ保存)
9. [設定を過去の状態へ戻す](#9-設定を過去の状態へ戻す)
10. [新しいMacへの復元](#10-新しいmacへの復元)
11. [困ったとき](#11-困ったとき)
12. [バックアップと定期確認](#12-バックアップと定期確認)
13. [設定ファイルの早見表](#13-設定ファイルの早見表)
14. [保存漏れの確認とGitの本人情報](#14-保存漏れの確認とgitの本人情報)

## 1. まず覚える操作

**キー表記の読み方**

- `Ctrl + d`：Controlを押しながらd。このMacの内蔵キーボードではCaps LockをControlとして使えます。
- `Space → f → s`：同時押しではなく、順番に押します。
- `Ctrl + b → c`：Controlとbを押して離してから、cを押します。
- `:w`：Neovimのノーマルモードで入力し、最後にEnterを押します。
- コード枠のコマンドはターミナル用です。ただし、先頭が `:` のものはNeovim内のコマンドです。

| 場所 | やりたいこと | 操作 |
|---|---|---|
| ターミナル | フォルダへ移動 | `cd フォルダ名` |
| ターミナル | ファイル一覧 | `ls`、隠しファイルも見るなら `la` |
| ターミナル | 編集を始める | `nvim ファイル名` または `v ファイル名` |
| Neovim | 文字を入力する | `i` |
| Neovim | 入力を終えて操作モードへ | `Esc` または素早く `j` → `k` |
| Neovim | 保存 | `:w`、または `Space → f → s` |
| Neovim | 保存して終了 | `:wq` |
| Neovim | ファイルを検索 | `Space → Space` |
| Neovim | 操作一覧を見る | ノーマルモードでSpaceを押して少し待つ |
| tmux | 作業を残して離れる | `Ctrl + b → d` |
| tmux | 残した作業へ戻る | ターミナルで `tmux attach -t work` |

**まずはtmuxを使わず、ターミナルとNeovimだけで慣れて構いません。**

## 2. このMacの構成

| 役割 | 使用するもの | 覚えておくこと |
|---|---|---|
| ターミナルアプリ | Alacritty | 画面の器。文字の大きさや透過はここで設定 |
| コマンドを解釈するシェル | zsh | `cd`、履歴、補完、エイリアスを担当 |
| プロンプト表示 | Starship | フォルダやGitなどの状態を表示 |
| エディター | Neovim 0.11.5 + LazyVim 16.0.1 | ファイル編集・補完・検索・LSP |
| 作業画面を分ける | tmux | セッション、ウィンドウ、ペインを管理 |
| 共通ツールの導入 | Homebrew | Git、Neovim、tmuxなど |
| 開発言語の切り替え | mise | Python、Node.js、Go、Rustなど |
| キーの変更 | Karabiner-Elements | Caps Lock → Controlなど |
| 設定の履歴・遠隔保存 | Git + GitHub | 公開リポジトリに保存 |

Alacrittyはフォント「HackGen Console NF」、サイズ11、透過率0.82、起動時SimpleFullscreenの設定です。見づらい場合は後述のAlacritty設定を編集します。

**保存した設定だけではMacの全データは戻りません。** 写真、書類、アプリ内部データ、パスワードは別のバックアップが必要です。Time Machineは作成時点で保存先未設定です。

## 3. キーボードと日本語入力

### 内蔵キーボード

- Caps Lockは左Controlとして動作します。Neovimの半ページ移動や分割移動に使えます。
- 左Commandを単独で押す操作は英数入力、右Commandを単独で押す操作はかな入力を送る設定です。
- Commandと別のキーの組み合わせは通常のCommand操作として扱う設定です。
- 外付けキーボードの一部には左Commandと左Controlを交換する機種別設定があります。内蔵と同じ物理位置とは限りません。

Neovimのコマンドが効かないときは、**英数入力へ切り替え、Escを押してから**試してください。文字入力中の `jk` は素早く押すとEscになり、ゆっくり押すと文字として入る場合があります。

### 「同じキーなのに動作が違う」場合

キーは現在操作しているアプリに届きます。Neovimの `Ctrl + j` は下の分割へ移動しますが、tmuxのペイン移動は `Ctrl + b → j` です。この2つは別の操作です。

Command-sにもNeovimの保存割り当てがありますが、端末がキーを渡さない場合があります。確実な基本操作は `Esc → :w → Enter` です。

## 4. ターミナルの基本

Spotlight（Command + Space）で「Alacritty」を探して開きます。設定変更後は新しいターミナルを開くと、新しい設定を読み込みます。

### 移動・表示

```sh
pwd                       # 今いるフォルダ
ls                        # 見やすい一覧（eza）
la                        # 隠しファイルも表示
cd ~/Documents            # Documentsへ移動
cd ..                     # ひとつ上へ
cd                        # ホームへ
mkdir -p ~/Documents/practice
```

フォルダ名に空白がある場合は `cd "フォルダ名"` のように引用符で囲みます。途中まで入力してTabを押すと補完できます。このMacではディレクトリ名だけを入力しても移動できます。

### 便利な操作

| 操作 | キー |
|---|---|
| 前のコマンドを見る | 上矢印 |
| 入力中のコマンド・動作を中断 | Ctrl + c |
| 画面を整える | Ctrl + l |
| 入力を補完 | Tab |
| パスや名前をコピー | 必要に応じてマウス選択・Command + c |

zshの履歴はターミナル間で共有されます。行頭に空白を付けたコマンドは、このzshの設定では履歴保存対象から外れます。ただし秘密情報は、そもそもコマンドへ直接書かない運用にしてください。

Ctrl-sで出力を止める機能は無効です。古いターミナルに変更前の状態が残る場合は、新しいターミナルを開いてください。

### 内容や場所を探す

```sh
bat README.md                  # ファイルの内容を見やすく表示
rg "検索したい文字" .           # 今のフォルダ以下の内容を検索
rg --files                     # 検索対象ファイルの一覧
command -v python node go      # 実際に選ばれる実行ファイル
```

`bat`などの表示がページ送りになった場合は `q` で抜けます。`rg`は通常、Gitの除外設定や隠しファイルを考慮します。

## 5. Neovimの使い方

### 最初の5分：練習用ファイルで試す

ターミナルで以下を実行します。

```sh
mkdir -p ~/Documents/practice
cd ~/Documents/practice
nvim memo.txt
```

1. `i` を押すと入力モードになります。
2. 「今日のメモ」などを入力します。
3. 英数入力に切り替え、Escを押します。
4. `:w` と入力してEnterを押すと保存します。
5. `:q` と入力してEnterを押すと終了します。
6. ターミナルで `nvim memo.txt` を再実行すると、保存内容を開けます。

### モードを区別する

| モード | 目的 | 入り方・戻り方 |
|---|---|---|
| ノーマル | 移動・検索・削除など | Escで戻る |
| 挿入 | 文字を書く | `i`、行末からなら `A` |
| ビジュアル | 範囲を選択 | `v`、行単位なら `V` |
| コマンド入力 | 保存・終了など | ノーマルモードで `:` |

### 編集の基本

以下はノーマルモードの操作です。

| 操作 | キー |
|---|---|
| 左・下・上・右へ | `h` / `j` / `k` / `l` |
| 単語の先へ・前へ | `w` / `b` |
| 行頭・行末へ | `0` / `$` |
| ファイル先頭・末尾へ | `gg` / `G` |
| 半ページ下・上へ | Ctrl + d / Ctrl + u |
| 下に新しい行を作って入力 | `o` |
| 1文字削除 | `x` |
| 1行削除 | `dd` |
| 1行コピー | `yy` |
| 貼り付け | `p` |
| 元に戻す・やり直す | `u` / Ctrl + r |
| 検索 | `/文字列` → Enter |
| 次の検索結果・前の結果 | `n` / `N` |

コピー・貼り付けはmacOSのクリップボードと共有する設定です。ビジュアルモードで選択し `y` でコピーできます。

### 保存・終了

| コマンド／キー | 動作 |
|---|---|
| `:w` | 保存 |
| `Space → f → s` | 保存（このMacの追加設定） |
| Ctrl + s | 保存（LazyVim） |
| `:q` | 現在のウィンドウを閉じる。未保存の変更があれば止まる |
| `:wq` | 保存して現在のウィンドウを閉じる |
| `:qa` | すべてのウィンドウを閉じる。未保存なら止まる |
| `:q!` | 現在のウィンドウを保存せず閉じる。変更を捨ててよいときだけ使う |

### ファイルを探す・開く

| 操作 | キー |
|---|---|
| ファイル名検索 | Space → Space |
| プロジェクト内の文字検索 | Space → / |
| ファイルツリー | Space → e |
| 開いているファイル一覧 | Space → , |
| 最近使ったファイル | Space → f → r |

検索画面では文字を入力して候補を絞り、矢印キーで選びEnterで開きます。Escで閉じられます。検索の基準フォルダは、現在の作業場所やGitなどから判断したプロジェクトルートです。

### 分割して編集する

以下のキー操作はノーマルモードで使います。

| 操作 | キー／コマンド |
|---|---|
| 左右分割 | `:vsplit` |
| 上下分割 | `:split` |
| 左・下・上・右の分割へ | Ctrl + h / j / k / l |
| 現在の分割を閉じる | `:q` |

Neovimの分割は、ひとつのNeovimの中で複数ファイルを見る機能です。次章のtmuxの分割は、別々のシェルやコマンドを並べる機能です。

### コードを書くとき

Lua、Python、JavaScript／TypeScript、Goの言語サーバーを設定済みです。対象ファイルやプロジェクトが認識されると、補完や診断などが使えます。

| 操作 | キー |
|---|---|
| 定義へ移動 | `gd` |
| 説明を見る | `K` |
| 名前を変更 | Space → c → r |
| 整形 | Space → c → f |
| LSP設定・状態を見る | Space → c → l |

補完はblink.cmp、検索とファイル操作はSnacks、整形はconform.nvimを使用します。**保存時の自動整形はオフ**です。Lua用styluaとシェル用shfmtは導入済みですが、PythonやTypeScriptの専用整形ツールは追加していません。整形可能かは言語サーバーやツールの状態によります。

### プラグイン管理

| Neovim内のコマンド | 用途 |
|---|---|
| `:Lazy` | プラグイン一覧と導入状況 |
| `:Mason` | 言語サーバー・外部ツール一覧 |
| `:LazyExtras` | 必要な機能の追加 |
| `:checkhealth` | 状態の診断 |
| `:Lazy restore` | lazy-lock.jsonに記録したプラグイン版へ戻す |
| `:Lazy update` | プラグイン更新。更新後は動作確認してGitに保存する |

LazyVim本体は16.0.1を指定しています。undo履歴とswapによる復旧を有効にしています。swap警告が出たら、別のNeovimで同じファイルを開いていないかを先に確認してください。

AI補完は今回の構成では自動有効化していません。`:LazyExtras`の選択記録である `lazyvim.json` もGit管理します。追加した機能を別のMacに復元するため、選択後の差分をcommit/pushしてください。

## 6. tmuxの使い方

### 始める・離れる・戻る

ターミナルで実行します。

```sh
tmux new -s work       # workという作業セッションを作る
tmux ls                # 残っているセッションを一覧表示
tmux attach -t work    # workへ戻る
```

すでにworkがあるときは、新規作成せずattachを使います。tmux内で `Ctrl + b → d` を押すと、作業を残して元のターミナルへ戻ります。Macの再起動後までプロセスが保存される仕組みではありません。

### 操作表

「prefix」は `Ctrl + b` を意味します。押して離してから次のキーを押します。

| 操作 | キー |
|---|---|
| 新しいウィンドウ | Ctrl + b → c |
| 次／前のウィンドウ | Ctrl + b → n / p |
| 次／前のウィンドウ（独自設定） | Shift + 右／左矢印 |
| 左右にペイン分割 | Ctrl + b → % |
| 上下にペイン分割 | Ctrl + b → " |
| 左・下・上・右のペインへ | Ctrl + b → h / j / k / l |
| ペインを一時的に最大化／戻す | Ctrl + b → z |
| スクロール・コピーモード | Ctrl + b → [ |
| 設定を読み直す | Ctrl + b → r |
| 作業を残して離れる | Ctrl + b → d |

コピーモードでは矢印や `h/j/k/l` で移動し、`v` で選択を始め、`y` またはEnterでmacOSのクリップボードへコピーします。Escや `q` でコピーモードから戻れます。

ペインのシェルを終了するには、実行中の作業を終えて `exit` を入力します。最後のペインを終了するとセッションも終わります。作業を残す目的ならexitではなくdetachを使います。

## 7. ツールと言語の管理

### このMacで固定しているバージョン

| ツール | バージョン |
|---|---|
| Go | 1.24.3 |
| Node.js | 22.16.0 |
| Python | 3.13.3 |
| Rust | 1.87.0 |
| mise管理のCodex CLI | 0.157.1 |

これは再現用の記録で、最新版を意味しません。実行場所やアプリから渡されたPATHにより、別の実行ファイルが優先される場合もあります。

```sh
mise ls --current
command -v python node go codex
python --version
node --version
go version
```

### どの管理ツールを使うか

- Git・Neovim・tmuxなどの共通コマンド：Homebrew。
- 言語のバージョン：mise。
- Neovimの言語サーバー：Neovim内のMason。
- プロジェクトのライブラリ：そのプロジェクトの仮想環境や依存ファイル。

```sh
brew list                   # Homebrewの導入一覧
brew outdated               # 更新候補を確認
mise ls                     # miseの導入・選択状況
```

ツールを追加したら、再現したいものをBrewfileまたはmise設定へ記録します。すべてのツールを一度に更新するより、変更対象を決めて更新し、動作確認してから保存すると原因を追いやすくなります。

miseの更新時は `/Users/vannamei/.config/mise/config.toml` を編集し、`mise install` で取得します。その後、次章のsnapshotでGit側へ取り込みます。`manifests/tool-versions.toml` は参照用記録なので、更新した版もここへ揃えます。

## 8. 設定を変更してGitHubへ保存

### 例：Alacrittyの文字を大きくする

```sh
nvim /Users/vannamei/dotfiles/.config/alacritty/alacritty.toml
```

`[font]` の `size = 11.0` を好みの値へ変更して保存します。Alacrittyは設定のライブ再読み込みが有効です。起動時の設定など、内容によっては次の起動から反映されます。

zsh・Neovimなどはdotfilesへのリンクで管理しています。編集内容はそのままGitの差分になります。miseとKarabinerは現在、別ファイルから取り込む方式です。

### 保存の標準手順

```sh
cd /Users/vannamei/dotfiles
./scripts/save.sh
git status --short
git diff
```

DockやFinderの設定も変更したときだけ、次も実行します。

```sh
python3 scripts/macos.py --capture
git diff
```

差分を確認して保存します。

```sh
git add .
git diff --cached
git commit -m "Update Mac settings"
git push origin main
```

このリポジトリは**公開**です。`git diff --cached`で、設定だけが入っているか確認します。APIキー、認証トークン、パスワード、秘密鍵は入れません。`git add .`は新しいファイルも対象にするため、確認は省かないでください。

**自動保存ではありません。** 編集だけではGitの履歴やGitHubに残らず、commitとpushが必要です。

## 9. 設定を過去の状態へ戻す

### 一部のファイルだけ戻す例

先に現在の作業を確認します。

```sh
cd /Users/vannamei/dotfiles
git status --short
git log --oneline -10
```

未保存の設定変更は、別コミットかコピーで残してから進めます。以下は、このマニュアルの基準コミットからzshとtmux設定を取り出す例です。

```sh
git restore --source=ea680f6 -- .zshrc .tmux.conf .config/tmux/.tmux.conf
git diff
```

このコマンドは指定ファイルの作業内容を置き換えます。変更内容を確認し、問題なければ復元を新しい履歴として保存します。

```sh
git add .zshrc .tmux.conf .config/tmux/.tmux.conf
git commit -m "Restore shell and tmux settings"
git push origin main
```

新しいターミナルを開き、tmuxは `Ctrl + b → r` で再読み込みします。

### 構成全体を戻す場合

復元対象には `.tmux.conf`、`.config`、`.zshrc`、`.zprofile`だけでなく、`install.sh`、`manifests`、`scripts`などの関連ファイルも含まれます。古い版では設定の配置やツール名も異なる場合があるため、差分を確認してから `./install.sh --apply` を実行します。

- Neovimを保存・終了してから設定を戻し、再起動後に `:Lazy restore` を実行。
- miseのファイルを戻しただけでは、未導入バージョンは増えません。必要に応じて `mise install`。
- macOS設定は `python3 scripts/macos.py --apply` で別途反映。
- 履歴を書き換えるforce-pushは通常不要です。

## 10. 新しいMacへの復元

### 事前準備

1. Macの初期設定とネット接続を済ませます。
2. ターミナルで `xcode-select --install` を実行し、画面に従ってCommand Line Toolsを導入します。
3. [Homebrew公式](https://brew.sh/)の手順でHomebrewを導入し、表示されたPATH設定の案内も実行します。
4. 既存の `~/dotfiles` がある場合は、内容を確認し、重ねてcloneしないでください。

### 設定を取得して適用

```sh
git clone https://github.com/vannamei/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

引数なしでは予定の表示だけです。確認して適用します。

```sh
./install.sh --apply --tools
```

- 設定を置き換える前に、既存のファイル・フォルダを退避します。
- 退避先は復元するMacの `~/.local/state/dotfiles-backups/日時-PID/`。
- Homebrewは既存ツールの一括更新を避けて導入します。ただし、新しいMacに過去と完全に同じバイナリが入ることを保証するものではありません。
- miseは設定ファイルの言語バージョンを導入します。

ツールを入れず設定だけを戻すなら `./install.sh --apply` です。

### 復元後の確認

1. 新しいターミナルで `mise ls --current` を確認。
2. `nvim`を開き、`:Lazy`と`:Mason`で取得完了を確認。初回取得中は終了しない。
3. Karabiner-Elementsを起動し、macOSが求める入力監視やシステム拡張の許可を行う。
4. 内蔵キーボードのCaps Lock + dなどでControl動作を確認。
5. `tmux new -s check`を開き、Ctrl + b → dで離れられることを確認。
6. 必要な場合だけDock/Finder等を適用。

```sh
python3 scripts/macos.py            # 予定の確認
python3 scripts/macos.py --apply    # 適用。変更前も退避する
```

追加のGUIアプリも戻すなら次を実行します。購入アプリ等のログインやライセンス認証は別途必要です。

```sh
brew bundle install --no-upgrade --file=Brewfile.apps
```

このMacのユーザー名はvannameiです。上の復元コマンドは `~` を使うため別ユーザー名にも対応しますが、本文の `/Users/vannamei/...` はこのMac専用のパスです。

## 11. 困ったとき

| 症状 | 最初に確認すること |
|---|---|
| Neovimで文字が入力できない | `i`で挿入モードへ。終了はEsc |
| Neovimのキー操作が効かない | 英数入力にしてEsc。Spaceの連続キーは順番に押す |
| 保存できない | `:w`のエラーを見る。新規ファイルは `:w ファイル名`。保存先の権限・空き容量を確認 |
| Ctrl-sで止まる | 新しいターミナルを開く。古い端末設定が残る場合はCtrl-qで解除を試す |
| Caps LockがControlにならない | Karabinerの起動、許可、選択プロファイル、対象キーボードを確認 |
| tmuxでCtrl-jが効かない | 旧セッションなら `tmux source-file ~/.tmux.conf` で読み直す |
| tmuxの分割に移れない | Ctrl + bを押して離してからh/j/k/l。Neovim内の分割と区別する |
| 補完・LSPが働かない | `:Mason`で導入状況、ファイル拡張子、プロジェクトの場所を確認 |
| 整形されない | 自動整形はオフ。Space c fを使い、対象言語の整形ツールも確認 |
| アイコンが四角になる | AlacrittyのHackGen Console NF設定とフォントの導入を確認 |
| コマンドが見つからない | 新しいターミナルで `command -v コマンド名`、`mise ls`、`brew list`を確認 |
| GitHubへpushできない | `gh auth status`。未認証なら本人のターミナルで `gh auth login` |
| pushがrejectedになる | `git status`とリモート差分を確認。安易なforce-pushはしない |
| プラグイン更新後に不調 | 保存済みのlazy-lock.jsonをGitから戻し、`:Lazy restore` |

### ヘルスチェックの注意点

前回の検証では、未使用のPHP・Java・Juliaや、任意のfd・fzf・lazygit等の未導入警告がありました。使う機能が必要とするかを確認して対処します。

nvim-treesitterには保存先末尾の `/` の表記差からruntimepath警告が残りましたが、主要言語の解析器のロード・解析は確認済みです。すべての警告を同じ原因と判断せず、実際の表示内容を確認してください。

自動検証環境ではmacOSのファイル監視が制限されるため、テスト中だけ監視を無効にしたことがあります。通常のNeovim設定では監視を無効にしていません。

## 12. バックアップと定期確認

### 現在の状態

- 設定：公開GitHubで管理。最新コミットは `git log -1 --oneline` で確認。
- 旧設定の退避：このチャットの出力フォルダに保存。
- Time Machine：保存先未設定。バックアップ完了扱いにはできません。
- ダウンロードから片付けた一部のファイル：以前ゴミ箱へ移動。現在も残っているかは別途確認が必要です。

Time Machineを始めるには、専用に使う外付けディスクまたは対応NASの保存先を決めます。ディスクの消去が必要と表示された場合は、既存データを保全してから進めます。GitHubだけでは文書や写真を保護できません。

### 設定変更のたびに

1. 変更した機能を実際に試す。
2. `git diff`で意図した設定だけが変わったことを確認。
3. commitとpush。
4. 操作キーや復元方法が変わったら、このマニュアルを更新。

### 月に一度の確認例

```sh
cd /Users/vannamei/dotfiles
git status --short
brew outdated
mise ls --current
df -h /System/Volumes/Data
tmutil destinationinfo
```

これらは確認用です。表示された更新や削除をすべて自動実行するものではありません。容量を減らすときは、用途を確認できるダウンロード・更新用キャッシュから検討します。

## 13. 設定ファイルの早見表

| 変更したい内容 | 編集・確認する場所 |
|---|---|
| zshの補完・履歴・別名・Ctrl-s | `/Users/vannamei/dotfiles/.zshrc` |
| ログイン時のHomebrew設定 | `/Users/vannamei/dotfiles/.zprofile` |
| プロンプトの見た目 | `/Users/vannamei/dotfiles/.config/starship.toml` |
| Alacrittyのフォント・透過・起動表示 | `/Users/vannamei/dotfiles/.config/alacritty/alacritty.toml` |
| tmuxのキーやコピー | `/Users/vannamei/dotfiles/.config/tmux/.tmux.conf` |
| tmux起動時の入口 | `/Users/vannamei/dotfiles/.tmux.conf`（設定本体へのリンク） |
| Neovimの基本設定 | `/Users/vannamei/dotfiles/.config/nvim/lua/config/options.lua` |
| Neovimの独自キー | `/Users/vannamei/dotfiles/.config/nvim/lua/config/keymaps.lua` |
| Neovimのプラグイン | `/Users/vannamei/dotfiles/.config/nvim/lua/plugins/` |
| Neovimの取得コミット | `/Users/vannamei/dotfiles/.config/nvim/lazy-lock.json` |
| 実際に使うmiseの言語設定 | `/Users/vannamei/.config/mise/config.toml` |
| 実際に使うKarabiner設定 | `/Users/vannamei/.config/karabiner/karabiner.json` |
| 復元対象ツール・アプリ | `/Users/vannamei/dotfiles/Brewfile`、`Brewfile.apps` |
| Macの表示・操作設定の保存値 | `/Users/vannamei/dotfiles/manifests/macos-preferences.json` |
| 復元スクリプト | `/Users/vannamei/dotfiles/install.sh` |
| 復元手順の原本 | `/Users/vannamei/dotfiles/README.md` |

**確認元**：上記の実設定、インストール済みLazyVimのキーマップ、miseの固定設定、macOSのバージョン表示、Time Machine保存先の照会。ハードウェアの詳細型番・メモリ容量は取得できなかったため記載していません。

## 14. 保存漏れの確認とGitの本人情報

```sh
cd /Users/vannamei/dotfiles
./scripts/save.sh --check   # 実設定とGit側の不一致を調べる。変更なし
./scripts/save.sh           # 取り込みと差分一覧の表示
```

Git側と実設定の両方が変更されていた場合は上書きせず停止します。両方を確認して統合してから、再実行してください。commit/pushはこれまでどおり差分確認後に行います。

Gitの名前・メールは `/Users/vannamei/.gitconfig.local` に分離しました。新しいMacではリポジトリ内の `.gitconfig.local.example` を参考に本人の値を設定します。GitHub用のnoreplyアドレスは本人のGitHubメール設定で確認できます。個人情報はGit管理へ戻さないでください。過去に公開した履歴は書き換えていません。

このマニュアルのGit管理版は `/Users/vannamei/dotfiles/docs/mac-manual.md` です。操作が変わったらこのファイルを編集し、設定と一緒に保存します。
