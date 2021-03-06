Setup Manual for Mac OS X
======================

Mac OS X セットアップ時の環境設定方法について記載する。

個人的なメモ書きのため、作者以外にはあまり参考になりません。

#### 条件

 * OS X 10.6 or later


#### 必要なもの

 * DropBox内のバックアップ
 * Evernote内のインストール情報


設定項目
--------

## Xcode と Command Line Tools for Xcode のインストール

#### インストール手順

1. Xcode をAppStoreからインストール
1. Command Line Tools のインストール
    * Xcodeを起動し、メニューから [Xcode] > [Preferences] > [Downloads] を開き、Command Line Tools をインストール


#### 確認

Xcodeのパスを確認

    $ xcode-select -print-path

Xcodeのパスが /Developer になっている場合は変更する

    $ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

Xcodeのパス変更を確認

    $ xcrun -find cc
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc
    $ xcrun -find gcc
    /Applications/Xcode.app/Contents/Developer/usr/bin/gcc
    $ xcrun -find clang
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang

## Homebrew 導入前準備

参考
[Macのパッケージ管理をMacPortsからhomebrewへ - よんちゅBlog](http://yonchu.hatenablog.com/entry/20110226/1298723822)

既に /usr/local が作成済みの場合は、/usr/local の所有権限を root:staff に変更

    $ chown root:staff /usr/local

Homebrew をインストール

[Homebrew Wiki](https://github.com/mxcl/homebrew/wiki/installation')

tomcat6.rbを追加(バックアップより)

## セットアップ

    GithubにSSH公開鍵を設定

    $ ~/dotfiles/etc/setup.sh


## /etc/zshenv を /etc/zprofile に変更 (OS X 10.7 or later)

OS X が10.7にアップデートした時に誤って,
/etc/zprofile を /etc/zshenv にしてしまったらしい。


zshをサブシェルとして実行するとPATHの設定がおかしくなってしまう。
また、zshでスクリプトを実行した場合もPATHがおかしくなってしまう。

    $ brew info zsh
    ….
    If you have administrator privileges, you must fix an Apple miss
    configuration in Mac OS X 10.7 Lion by renaming /etc/zshenv to
    /etc/zprofile, or Zsh will have the wrong PATH when executed
    non-interactively by scripts.

    Alternatively, install Zsh with /etc disabled:

      brew install --disable-etcdir zsh

よって以下のように変更する

    $ ls -l /etc/zshenv
    -r--r--r--   1 root wheel  126 2012-04-06 03:56 zshenv
    $ sudo mv /etc/zshenv /etc/zprofile
    $ ls -l /etc/zprofile
    -r--r--r--   1 root wheel  126 2012-04-06 03:56 zprofile


## bash/zsh の設定ファイルについて

 - zsh
    - ~/.zshenv
    - ZDOTDIR/.zprofile
        - \-> ~/dotfiles/.profile
        - \-> ~/dotfiles/.profile.osx
    - ZDOTDIR/.zshrc
        - \-> ~/.zsh/.zprompt
        - \-> ~/dotfiles/.alias
        - \-> ~/.zsh/.zalias
        - \-> ~/dotfiles/.shrc.local
    - ZDOTDIR/.login


 - bash
    - ~/.bash\_profile
        - \-> ~/dotfiles/.profile
        - \-> ~/dotfiles/.profile.osx
    - ~/.bashrc
        - \-> ~/dotfiles/.alias
        - \-> ~/dotfiles/.shrc.local

## vim

MacVim-KaoriYa インストール

[macvim-kaoriya - MacVim KaoriYa - Google Project Hosting](http://code.google.com/p/macvim-kaoriya/)

vim-powerlineの個別変更(キャラコード/文字数(マルチ文字対応))

    ~/dotfiles/.vim/bundle/vim-powerline/autoload/Powerline/Segments.vim
    - \ Pl#Segment#Create('line.cur'    , '$LINE %3l'),
    - \ Pl#Segment#Create('line.tot'    , ':%-2v', Pl#Segment#NoPadding()),
    + \ Pl#Segment#Create('line.cur'    , '$LINE %3l/%-3L'),
    + \ Pl#Segment#Create('line.tot'    , ':%-3v', Pl#Segment#NoPadding()),

vim-powerline対応のフォントをインストール

Dropboxのバックアップを使用

Ricty,  Envy Code R, うにフォント, あずきフォント...etc
<br><br>
vim-powerlineのキャッシュクリア

    $ vim -c PowerLineClearCache -c quitall

## 動作確認

ログインシェル変更前に入念に動作チェックを行う。

## ログインシェルをzshに変更

現在のログインシェルを確認

    $ chpass

ログインシェルに設定可能なシェルの一覧を確認

    $ cat /etc/shells

ログインシェルの一覧の最終行に /usr/local/bin/zsh を追加

    $ sudo vi /etc/shells

ログインシェルをzshに変更

    $ chpass -s /usr/local/bin/zsh

変更の確認

    $ chpass

OSを再起動し、「システム環境設定」→「ユーザーとグループ」で、アカウントを右クリック、
「詳細オプション」を表示して、ログインシェルが変更されていれば成功。


## screen256colorのインストール

    $ cd ~/work/usr/local/src
    $ cd ~/work/usr/local/src
    $ mkdir screen
    $ cd screen

[ここ](http://www.frexx.de/xterm-256-notes/) から 256colors2.pl をDL

    $ curl -OLv http://www.frexx.de/xterm-256-notes/data/256colors2.pl
    $ ./256color2.pl

screenの最新版をGithubからCloneし、インストール

    $ git clone git://git.sv.gnu.org/screen.git
    $ cd screen/rc
    $ sudo ./autogen.sh
    $ sudo ./autoheader.sh
    ($ ./autogen.sh)
    $ ./configure --prefix=~/work/usr/local --enable-colors256
    $ make
    $ make install

screenを実行した状態で 256colors2.pl を実行して確認

    $ ~/work/usr/local/bin/screen
    $ ./256color2.pl

~/binにシンボリックリンクを作成

    $ cd ~/bin
    $ ln -s ~/work/usr/local/bin/screen screen


## ターミナル

Terminal.appの設定変更

iTerm2をインストールし、バックアップから設定を復旧

 * ~/Library/Preferences/com.googlecode.iterm2.plist


## 日本語man(jman)をインストール

下記サイトより、必要なファイルをDLしてインストール

 <http://www.fan.gr.jp/~sakai/softwares/unix>

    $ cd ~/work/usr/src/
    $ mkdir jman
    $ cd jman
    $ curl -LOv http://www.fan.gr.jp/~sakai/files/jman-20080103r2.dmg
    $ curl -LOv http://www.fan.gr.jp/~sakai/files/manpages-ja_JP-20080103r2.dmg

DLしたファイルを実行

/usr/local/jman 以下に必要なファイルがインストールされ、 /usr/local/bin にjmanコマンドがインストールされる。


## 日本語man(JM Project - Linxu/GNU系)をインストール

下記サイトより全体アーカイブをDL

[JM Project (Japanese)](http://linuxjm.sourceforge.jp/)

    $ make config
    perl -w script/configure.perl
    [INSTALLATION INFORMATION]
    (just Return if you accept default)
    Install directory   [/usr/share/man/ja_JP.UTF-8] ?: /Users/<username>/work/usr/local/share/man/ja_JP.UTF-8
    compress manual with..
      0: none
      1: gzip
      2: bzip2
      3: compress
    select [0..3] : 0
    uname of page owner [root] ?: <username>
    group of page owner [root] ?: staff

       Directory:    /Users/<username>/work/usr/local/share/man/ja_JP.UTF-8
       Compression:  none
       Page uid/gid: <username>/staff

    All OK? (Yes, [C]ontinue / No, [R]eselect) : c

    以下全て Enter or c -> Enter


## MacAPPをインストール

 - スティッキーズの内容復元
 - Google IME - 不要なモードOFF、ESCなどでIME-OFF
 - KeyRemap4MacBook の設定復元
 - ClipMenu の内容復元
 - Eclipse の復元
 - KeyBindings の復元
 - workflow/scripts の復元
 - CotEditorの復元
 - clamxav
 - MySQL
 - Ecliplse + jad
 - VirtualBox + CentOSなど
 - etc (その他のアプリはEvernote参照)


## DashboardのWidgetをインストール

 - iCalのカラー版
 - TunesTEXT
 - ニコ生Widget
 - 週間天気
 - 辞書
 - 翻訳
 - TeleMania(TV番組表)
 - DeepSleep
 - 電卓
 - 鉄道運行情報
 - iStat Pro
 - Kitchen Timer


## sshの設定

 - .ssh/config
 - 公開鍵/秘密鍵
 - authorized\_keys


## pythonbrew

Evernoteのメモを参照

$ pip freeze
debug
distribute
flake8
ipython
pep8
pudb
pyflakes
readline
wsgiref
see

    $ ln -s ~/dotfiles/etc/python/sitecustomize.py ~/.pythonbrew/venvs/Python-2.7.3/py273/lib/python2.7/site-packages/sitecustomize.py

## ruby(rvm/gem)

Evernoteのメモを参照

$ gem list
git-browse-remote
rvm
tw

## ディレクトリ構成の復活

 - $HOME/
 - $HOME/Documents/\*
 - $HOME/work
 - $HOME/work/dev
 - $HOME/work/tips
 - $HOME/work/usr
 - $HOME/work/usr/local
 - $HOME/work/usr/src
 - /usr/local


## その他DropBoxのバックアップから復元


## gccのインストール

 手動 or 非公式インストーラ or homebrew

 <http://holidayworking.org/memo/2011/12/29/1/>

 <http://toggtc.hatenablog.com/entry/2012/01/28/224006>


## dotfile.local

dotfiles.local をDropBox上のリモートリポジトリよりクローン

個別環境に応じて設定を変更(適当)


## Sublime Text 2 のインストール

DropBoxから設定を復元

    $ cd ~/Library/Application Support
    $ mv Sublime\ Text\ 2 ~/.Trash
    $ ln -s $HOME/Dropbox/Repos/Apps/Sublime\ Text\ 2 Sublime\ Text\ 2

実行ファイルのシンボリックリンクを作成

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl ~/bin/subl


# vim: ft=markdown
