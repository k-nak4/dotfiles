# PostMail

## 動かない時に見るところ

1. ディレクトリのパーミッション
2. 各種ファイルのパーミッション
3. perlやsendmailなどのパス
4. ***改行コードをLFにする(lolipopサーバはlinux鯖のためCRやCRLFだと動かない)***

## 必須項目をつくる

```html
<input type="hidden" name="need" value="入力必須にしたい項目のnameの値を入力 空白区切りで 複数指定可能">
```

または、nameの値の前に_を挿入する.

```html
<input type="text" name="_email">
```

上記のようにするとメールが入力必須項目となる
