## Modelsimの起動

```~/intelFPGA/16.1/modelsim_ase/linux/vsim```

## vishの依存関係エラーを解決する

```
$ ldd vish
libXft.so.2 => not found
```

## 共有ライブラリが含まれるパッケージを検索する

```
$ sudo apt-get install apt-file
$ sudo apt-file update
$ apt-file search libXft.so.2
libxft2: /usr/lib/x86_64-linux-gnu/libXft.so.2
```

上記の結果から、libxft2パッケージに含まれていることがわかったのでインストールする。 i386アーキテクチャ用のライブラリが欲しいので、パッケージの末尾に:i386をつけてインストール

```
$ sudo apt-get install libxft2:i386
```

## プロキシー環境下でapt-getが通らない場合

```
$ sudo -E apt-get update
```


## まとめ
ldd -> apt-file search -> apt-getでおk
