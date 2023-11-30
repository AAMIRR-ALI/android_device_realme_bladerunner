#
# Copyright (C) 2020 The LineageOS Project
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

# Inherit some common risingOS stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Call the BCR setup
$(call inherit-product-if-exists, vendor/bcr/bcr.mk)

#For official Devices:
MATRIXX_BUILD_TYPE := Official
MATRIXX_MAINTAINER := AAMIR_ALI
MATRIXX_CHIPSET := SM8250
MATRIXX_BATTERY := 4200mAh
MATRIXX_DISPLAY := 1080x2400

#EPPE
TARGET_DISABLE_EPPE := true

#BOOT_ANIMATION
TARGET_BOOT_ANIMATION_RES := 1440

#AUDIOFX
TARGET_EXCLUDES_AUDIOFX := true

#Build with Gapps:
WITH_GAPPS := true

#Add Google Dialer & Messaging
#EXTRA_GAPPS := true

#Device has UDFPS:
TARGET_HAS_UDFPS := true

#Blur effect
TARGET_ENABLE_BLUR := true

#Add Google Contacts, Dialer & Messaging 
EXTRA_GAPPS := true

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
    PRIVATE_BUILD_DESC="RMX2076-user 12 RKQ1.211103.002 Q.202207142209 release-keys" \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

BUILD_FINGERPRINT := realme/RMX2076/RMX2076L1:12/RKQ1.211103.002/Q.202207142209:user/release-keys
