LDL_DEFINES += -DLDL_ENABLE_SX1272
LDL_DEFINES += -DLDL_ENABLE_SX1276
LDL_DEFINES += -DLDL_ENABLE_AU_915_928
LDL_DEFINES += -DLDL_ENABLE_EU_863_870
LDL_DEFINES += -DLDL_ENABLE_EU_433
LDL_DEFINES += -DLDL_ENABLE_US_902_928
LDL_DEFINES += -DLDL_ENABLE_STATIC_RX_BUFFER

LDL_INCLUDE += -Ivendor/lora_device_lib/include

LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_mac.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_mac_commands.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_frame.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_ops.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_sm.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_stream.c
LDL_SRC_MAC += vendor/lora_device_lib/src/ldl_system.c
LDL_SRC_MAC += ldl_dummy_mac.c

LDL_SRC_RADIO += vendor/lora_device_lib/src/ldl_radio.c
LDL_SRC_RADIO += ldl_dummy_radio.c

LDL_SRC_REGION += vendor/lora_device_lib/src/ldl_region.c

LDL_SRC += $(LDL_SRC_MAC)
LDL_SRC += $(LDL_SRC_RADIO)
LDL_SRC += $(LDL_SRC_REGION)
