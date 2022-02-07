sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.spider
make menuconfig KCONFIG_CONFIG=config.spider
make KCONFIG_CONFIG=config.spider
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_stm32f446xx_35001C000750305538333620-if00 fysetc-spider-v1

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

sudo service klipper start