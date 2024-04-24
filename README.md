# Trident_backup
########### Hardware ###########

MCU
https://docs.vorondesign.com/build/software/octopus_klipper.html
	
	BTT Octopus v1.1
	STM32F446
	32KiB bootloader
	12 MHz clock
	Comm interface (USB (on PA11/PA12)
	serial: /dev/serial/by-id/usb-Klipper_stm32f446xx_310030000550314D35323820-if00

Toolhead
https://github.com/bigtreetech/EBB/tree/master/EBB%20CAN%20V1.0%20(STM32F072)
https://github.com/maz0r/klipper_canbus/blob/main/toolhead/ebb36-42_v1.0.md
	
	EBB36 
	STM32F072
	8KiB offset
	8 MHz clock
	canbus UUID: fb6ec5943d28

Klipper expander
https://github.com/VoronDesign/Voron-Hardware/blob/master/Klipper_Expander/Documentation/README.md#seup 
	
	STM32F042
	no bootloader
	internal clock
	DFU [0483:df11]
	serial: /dev/serial/by-id/usb-Klipper_stm32f042x6_210027000943535031303420-if00 
 
########### firmware ###########

autoupdate firmware command

***disable "off_when_shutdown: True" in moonraker.conf prior to running updates***
~~~~~~~~~~~~~~~~~~~~~
cd ~/klipper
sudo bash update-all.sh
~~~~~~~~~~~~~~~~~~~~~~
autoupdate firmware code
~~~~~~~~~~~~~~~~~~~~~~
sudo service klipper stop
cd ~/klipper
git pull

#MCU
make clean KCONFIG_CONFIG=config.octopus
make menuconfig KCONFIG_CONFIG=config.octopus
make KCONFIG_CONFIG=config.octopus
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_2B0028000850314D35323820-if00 KCONFIG_CONFIG=config.octopus

#LinuxHost
make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

#toolhead
make clean 
make menuconfig 
make 
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u fb6ec5943d28

#expander
#expander serial: /dev/serial/by-id/usb-Klipper_stm32f042x6_210027000943535031303420-if00 DFU [0483:df11]
#make clean 
#make menuconfig 
#make
#make flash FLASH_DEVICE=0483:df11 

sudo service klipper start
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After hard reset - recreate gcode_shell_command.py
https://github.com/th33xitus/kiauh/blob/master/resources/gcode_shell_command.py
