# SPDX-License-Identifier: GPL-2.0-only
#
# Makefile for the Realtek network device drivers.
#

CONFIG_R8169 = m

ENABLE_INCLUDE_R8168 = n
ENABLE_INCLUDE_R8125 = n

ifeq ($(ENABLE_INCLUDE_R8168), y)
	EXTRA_CFLAGS += -DINCLUDE_R8168
endif

ifeq ($(ENABLE_INCLUDE_R8125), y)
	EXTRA_CFLAGS += -DINCLUDE_R8125
endif

r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
obj-$(CONFIG_R8169) += r8169.o
