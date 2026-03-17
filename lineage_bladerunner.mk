#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from bladerunner device
$(call inherit-product, device/realme/bladerunner/device.mk)

# Inherit some common lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# AxionAOSP Specific Flags.
AXION_MAINTAINER := YAZZDAN
AXION_PROCESSOR := Snapdragon®_865
TARGET_SUPPORTED_REFRESH_RATES := 60,75,90

# Camera
AXION_CAMERA_REAR_INFO := 64,8,2
AXION_CAMERA_FRONT_INFO := 16

TARGET_DISABLE_EPPE := true
TARGET_ENABLE_BLUR := true
TARGET_PREBUILT_BCR := true
TORCH_STR_SUPPORTED := true
TARGET_INCLUDE_VIPERFX := true
TARGET_FACE_UNLOCK_SUPPORTED := true


PRODUCT_NAME := lineage_bladerunner
PRODUCT_DEVICE := bladerunner
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX2076
PRODUCT_MANUFACTURER := realme

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="RMX2076-user 12 SKQ1.211019.001 1650437182763 release-keys" \
    BuildFingerprint=realme/RMX2076/RMX2076L1:12/SKQ1.211019.001/1650437182763:user/release-keys \
    DeviceName=RMX2076L1 \
    DeviceProduct=RMX2076 \
    SystemDevice=RMX2076L1 \
    SystemName=RMX2076
