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
