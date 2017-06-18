## ドライバの状態を確認

```
$ lspci -k
```

## インターフェースの立ち上げ

```
# ip link set <interface> up
```

## ERROR: Operation not possible due to RF-kill

### 1. RF-killのリストを表示

```
# rfkill list
```

### 2. ソフトブロックを解除

```
# rfkill unblock wifi
```
