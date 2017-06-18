# Linuxで外付けHDDを自動マウントするように設定する

もともとはfstabに記述して自動でマウントされるようにしていたが、この方法はよろしくないなと思うような出来事があったので、解決策を考えることにした。

## 案1 

cronの@rebootマクロを使って起動時にマウントさせる

## 案2

autofsであああああああああああ

2案で行きます。

これでデバイスがどこにマップされたかを確かめる。
```
$ dmesg | tail -n 22
```
さっき調べたデバイスのUUIDを調べる
```
$ ls -al /dev/disk/by-uuid/ | grep sda1

3D34-45EF -> ../../sda1
```
この場合3D34-45EFがUUIDとなる

```
sudo mount /dev/disk/by-uuid/4E38-A068 /mnt/media/ -t vfat -o codepage=932,iocharset=utf8,umask=000
```
umask=000は一般ユーザでも書き込み権限が与えられるオプション

## autofsの導入

```
$ sudo apt-get install autofs
```

```
$ sudo vim /etc/auto.master
#/misc	/etc/auto.misc
上の1行をコメントアウト
```
外付けHDDのUUIDをauto.miscに登録する

```
$ sudo vim /etc/auto.misc
fathdd	fstype=vfat,option	:/dev/disk/by-uuid/ABCD-1234

終わったら
$ sudo /etc/init.d/autofs restart
$ ls -al /misc/fathdd
```
