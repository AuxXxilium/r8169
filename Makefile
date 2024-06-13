
# SPDX-License-Identifier: GPL-2.0-only
################################################################################
#
# r8169 is the Linux device driver released for Realtek Gigabit Ethernet
# controllers with PCI-Express interface.
#
# Author:
# Copyright (c) 2002 ShuChen <shuchen@realtek.com.tw>
# Copyright (c) 2003 - 2007 Francois Romieu <romieu@fr.zoreil.com>
# Copyright (c) a lot of people too. Please respect their work.
#
################################################################################

################################################################################
#  This product is covered by one or more of the following patents:
#  US6,570,884, US6,115,776, and US6,327,625.
################################################################################

# Set the kernel build directory
KDIR ?= "/lib/modules/$(shell uname -r)/build"
# Directory for module updates
MUPDATE ?= "/lib/modules/$(shell uname -r)/updates"
# Hash for signing
HASH = sha3-512
obj-m := r8169.o
r8169-objs := r8169_main.o r8169_firmware.o r8169_phy_config.o r8169_leds.o

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

modules_install:
	$(MAKE) -C $(KDIR) M=$(PWD) modules_install

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
        ifdef $(MUPDATE)
	$(MAKE) -c $(KDIR) M=$(MUPDATE) clean
        endif

sign:
	/usr/src/linux/scripts/sign-file $(HASH) /usr/src/linux/certs/signing_key.pem /usr/src/linux/certs/signing_key.x509 r8169.ko

.PHONY: all modules_install clean sign
