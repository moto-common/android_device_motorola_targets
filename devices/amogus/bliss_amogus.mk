# Copyright 2014 The Android Open Source Project
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

# Boot Animation stuff
TARGET_BOOT_ANIMATION_RES := 1080

# Common
include device/motorola/targets/include/common.mk

# foss apps
#$(call inherit-product-if-exists, vendor/foss/foss.mk)
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Gapps
#TARGET_ESSENTIAL_GAPPS := true
TARGET_STOCK_GAPPS := true

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/bliss/config/common_full_phone.mk)

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# NoNearbySharingOverlay
PRODUCT_PACKAGES += \
    NoNearbySharingOverlay

# Libhidl
PLATFORM_PROVIDES_LIBHIDL := true

# Required Scripts
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)

PRODUCT_NAME := bliss_$(DEVICE)
