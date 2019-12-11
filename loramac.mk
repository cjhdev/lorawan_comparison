LORAMAC_DEFINES += -DREGION_EU868
LORAMAC_DEFINES += -DREGION_EU433
LORAMAC_DEFINES += -DREGION_US915
LORAMAC_DEFINES += -DREGION_AU915

LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/mac
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/system
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/radio
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/radio/sx1272
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/radio/sx1276
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/peripherals
LORAMAC_INCLUDE += -Ivendor/LoRaMac-node/src/boards

LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMac.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacCommands.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacConfirmQueue.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacSerializer.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacAdr.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacParser.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/mac/LoRaMacCrypto.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/system/timer.c
LORAMAC_SRC_MAC += vendor/LoRaMac-node/src/peripherals/soft-se/soft-se.c

LORAMAC_SRC_RADIO += vendor/LoRaMac-node/src/radio/sx1276/sx1276.c
LORAMAC_SRC_RADIO += vendor/LoRaMac-node/src/radio/sx1272/sx1272.c

LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/Region.c
LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/RegionAU915.c
LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/RegionCommon.c
LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/RegionEU433.c
LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/RegionEU868.c
LORAMAC_SRC_REGION += vendor/LoRaMac-node/src/mac/region/RegionUS915.c

LORAMAC_SRC += $(LORAMAC_SRC_MAC)
LORAMAC_SRC += $(LORAMAC_SRC_RADIO)
LORAMAC_SRC += $(LORAMAC_SRC_REGION)
