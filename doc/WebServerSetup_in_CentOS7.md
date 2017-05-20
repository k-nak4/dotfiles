# CentOS7.3の初期設定からWebサーバを構築するまで

## 注意点

サーバ構築初心者のメモ書きです。
コンソールモード(CUI)を想定しています。

プロンプトの表記は'%'がroot、'$'が一般ユーザを示しています。
'#'記号から行末まではコメントです。

```
% echo "root user" # Comment.
$ echo "general user"
```

<br>

環境によって書き換える必要がある部分は"<文字列>"を使って示しています。

```
% <editor> hoge.txt
```
このように表記されているときは、
```
% nano hoge.txt
% vi hoge.txt
% emacs hoge.txt
```
このように、自分の好きなエディタに書き換えてください。

<br>

## 環境

| OS/Middle | Version |
|:----------|:--------|
| CentOS    | 7.3     |
| Nginx     | 1.12.0  |

## 初期設定

### yumをアップデートする

```
% yum update
```

### hostnameを変更

```
% hostnamectl set-hostname <host_name>
```

### 一般ユーザを作成する

```
% useradd <user_name>
% passwd <user_name> # passwordを設定
```

### 一般ユーザにsudo権限を与える

```
% visudo
```

以下の1行をファイルの下部などに追加する。
```
<user_name>  ALL=(ALL) ALL
```

### 一般ユーザでsudoが利用できることを確認する
```
% su <user_name> # 先ほど作成したユーザのパスワードを入力
$ sudo ls
```
正常にlsが実行されたらOKです。

### rootユーザをログアウトさせる

```
$ exit # suコマンドで立ち上げたシェルを終了
% exit # rootをログアウト
```
これ以降は作成したユーザを使って設定していきます。

<br>

## ssh環境の構築

### openssh-serverのインストールを確認

```
yum list installed | grep openssh-server
```
インストールされていなかったら、
``` $ sudo yum install openssh-server```
でインストール。

### sshdの設定（最低限必要と思われるもののみ）
```sudoedit /etc/ssh/sshd_config```

```
# SSHに使用するポート番号の指定(変更を推奨)
Port <Port番号>
# SSHのバージョン2のみを許可
Protocol 2
# 公開鍵認証の有効化
PubkeyAuthentication yes
# パスワード認証の有効化(あとで無効化します)
PasswordAuthentication yes
# Rootユーザのログインを無効化
PermitRootLogin no
# RSA認証の無効化
RSAAuthentication no
# チャレンジレスポンス認証を無効化
ChallengeResponseAuthentication no
# ケルベロス認証を無効化
KerberosAuthentication no
# GSSAPI認証を無効化
GSSAPIAuthentication no
```

### sshdを起動
```
$ sudo systemctl start sshd.service # サービスの立ち上げ
$ sudo systemctl status sshd.service # ステータスを確認
```

### sshで使用するポートを解放する
```
$ sudo firewall-cmd --add-port=<Port番号>/tcp --zone=public --permanent
$ sudo firewall-cmd --reload
```

<br>

## 公開鍵認証のための設定を行う

設定をするのがサーバなのかクライアントなのか紛らわしくなるのでこの節のみ[server], [client]と表記します。

### .sshディレクトリとauthorized_keysファイルを作成
```
[server]$ mkdir -p ~/.ssh
[server]$ touch ~/.ssh/authorized_keys
[server]$ chmod 700 ~/.ssh
[server]$ chmod 600 ~/.ssh/authorized_keys
```

### クライアント側で鍵のペアを作成し、サーバ#に公開鍵を送信する。
```
[client]$ ssh-keygen -t ed25519
[client]$ scp -P <Port番号> ~/.ssh/ed25519.pub <user_name>@<xxx.xxx.xxx.xxx>:~/.ssh
```

### 公開鍵をサーバに登録し、パスワード認証を無効化する。
```
[server]$ cat ~/.ssh/ed25519.pub >> authorized_keys
[server]$ sudoedit /etc/ssh/sshd_config
[server]$ sudo systemctl restart sshd.service
```

### 接続テスト
```
[client]$ ssh -i ~/.ssh/id_ed25519 -p <Port番号> <user_name>@<xxx.xxx.xxx.xxx>
```

### クライアント側の~/.ssh/configの設定(任意)
```
ServerAliveInterval 60

Host <host_name>
  HostName <xxx.xxx.xxx.xxx>
  User <user_name>
  Port <Port番号>
  IdentityFile ~/.ssh/<秘密鍵>
```

上記のように設定するとsshをする際に記述する文字数が少なくて済む。
```
$ ssh <host_name>
```

<br>

## Webサーバのインストール

### Nginxをビルドするためのライブラリをインストール
```
$ sudo yum install gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel
```

### Nginx用ユーザ作成
```
$ sudo useradd --shell /sbin/nologin nginx
```

### Nginxをダウンロード
[公式サイト](http://nginx.org/en/download.html)からソースをダウンロード。今回はStable versionから選択。
```
$ wget http://nginx.org/download/nginx-1.12.0.tar.gz
$ tar xvzf nginx-1.12.0.tar.gz
```
