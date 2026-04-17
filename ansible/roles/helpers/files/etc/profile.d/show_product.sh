#!/bin/sh

# show_product.sh
(
cd /sys/devices/virtual/dmi/id
echo $(cat sys_vendor) $(cat product_version) $(cat product_name) bios: $(cat bios_release) $(cat bios_date) board: $(cat board_name)
)
