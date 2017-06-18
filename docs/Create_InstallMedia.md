# インストールメディアの作成(USB)

## 手順

1. isoファイルを取得
2. isoファイルをimgファイルに変換
3. usbに書き込む

## iso -> img

```$ hdiutil convert -format UDRW -o /path/arch.img /path/arch.iso```

## usbへ書き込み

```
$ diskutil list
$ diskutil unmountDisk /dev/diskN
$ sudo dd if=/path/arch.dmg of=/dev/diskN bs=1m
```
