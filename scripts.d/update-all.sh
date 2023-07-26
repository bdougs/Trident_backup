sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.octopus
make menuconfig KCONFIG_CONFIG=config.octopus
make KCONFIG_CONFIG=config.octopus
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_stm32f446xx_310030000550314D35323820-if00 btt-octopus-f446-v1.1

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

sudo service klipper start