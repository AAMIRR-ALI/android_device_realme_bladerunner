#
# Copyright (C) 2024 The RisingOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

$(call inherit-product, vendor/extras/config.mk)

# Inherit from device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_bladerunner
PRODUCT_DEVICE := bladerunner
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX2076
PRODUCT_MANUFACTURER := realme

PRODUCT_SYSTEM_NAME := RMX2076
PRODUCT_SYSTEM_DEVICE := RMX2076L1

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="RMX2076-user 12 SKQ1.211019.001 1650437182763 release-keys" \
    BuildFingerprint=realme/RMX2076/RMX2076L1:12/SKQ1.211019.001/1650437182763:user/release-keys \
    DeviceName=RMX2076L1 \
    DeviceProduct=RMX2076 \
    SystemDevice=RMX2076L1 \
    SystemName=RMX2076
