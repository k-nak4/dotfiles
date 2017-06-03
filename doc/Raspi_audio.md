# Raspi-audio

## /etc/modprobe.d/alsa-base.confがねえ！！

```bash
sudo modprobe snd-pcm-oss
```

## juliusを用いた音声認識

### オーディオカードの優先順位の確認

```bash
sudo cat /proc/asound/modules
```
