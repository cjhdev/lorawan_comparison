include ldl.mk 
include loramac.mk 

DIR_TOOLCHAIN ?= /opt/arm/gcc-arm-none-eabi-8-2018-q4-major/bin

PREFIX     := $(DIR_TOOLCHAIN)/arm-none-eabi

GXX        := $(PREFIX)-g++
CC         := $(PREFIX)-gcc
AR         := $(PREFIX)-ar
OBJCOPY    := $(PREFIX)-objcopy
OBJDUMP    := $(PREFIX)-objdump
SIZE       := $(PREFIX)-size
GDB        := $(PREFIX)-gdb


version:
	@ $(CC) --version

# LDL ##################################################################

build/ldl_mac.a: INCLUDES += $(LDL_INCLUDE)
build/ldl_mac.a: DEFINES += $(LDL_DEFINES)
build/ldl_mac.a: $(addprefix build/, $(LDL_SRC_MAC:.c=.o))
	@ $(AR) cr $@ $^

build/ldl_radio.a: INCLUDES += $(LDL_INCLUDE)
build/ldl_radio.a: DEFINES += $(LDL_DEFINES)
build/ldl_radio.a: $(addprefix build/, $(LDL_SRC_RADIO:.c=.o))
	@ $(AR) cr $@ $^

build/ldl_region.a: INCLUDES += $(LDL_INCLUDE)
build/ldl_region.a: DEFINES += $(LDL_DEFINES)
build/ldl_region.a: $(addprefix build/, $(LDL_SRC_REGION:.c=.o))
	@ $(AR) cr $@ $^

# LoRaMAC ##################################################################

build/loramac_mac.a: INCLUDES += $(LORAMAC_INCLUDE)
build/loramac_mac.a: DEFINES += $(LORAMAC_DEFINES)
build/loramac_mac.a: $(addprefix build/, $(LORAMAC_SRC_MAC:.c=.o))
	@ $(AR) cr $@ $^

build/loramac_radio.a: INCLUDES += $(LORAMAC_INCLUDE)
build/loramac_radio.a: DEFINES += $(LORAMAC_DEFINES)
build/loramac_radio.a: $(addprefix build/, $(LORAMAC_SRC_RADIO:.c=.o))
	@ $(AR) cr $@ $^

build/loramac_region.a: INCLUDES += $(LORAMAC_INCLUDE)
build/loramac_region.a: DEFINES += $(LORAMAC_DEFINES)
build/loramac_region.a: $(addprefix build/, $(LORAMAC_SRC_REGION:.c=.o))
	@ $(AR) cr $@ $^

size_%: build/%.a
	@ $(SIZE) $<

build/%.o: %.c
	@ echo building $@
	@ mkdir -p $(dir $@)
	@ $(CC) $(CFLAGS) $(INCLUDES) $(DEFINES) -c $< -o $@

ARCHFLAGS += -mcpu=cortex-m0plus -mthumb -march=armv6-m -mfloat-abi=soft -mlittle-endian

CFLAGS    += -Os
CFLAGS    += $(ARCHFLAGS)
CFLAGS    += -Wall -std=c99

CFLAGS    += -ffunction-sections -fdata-sections
CFLAGS    += $(INCLUDES)
CFLAGS    += -specs=nano.specs
#CFLAGS    += -specs=nosys.specs
CFLAGS    += -nostdlib 
#
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -Wl,-Map=bin/$(TARGET).map 
LDFLAGS += -Wl,-T$(DIR_ROOT)/$(MCU).ld

clean: 
	rm -rf build/*

.PHONY: clean version
