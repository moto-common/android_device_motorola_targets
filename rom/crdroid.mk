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

# Common
include device/motorola/targets/include/common.mk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1080

# Build fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cheetah-user 13 TQ2A.230305.008.C1 9619669 release-keys"

BUILD_FINGERPRINT := google/cheetah/cheetah:13/TQ2A.230305.008.C1/9619669:user/release-keys

# Face unlock
TARGET_SUPPORT_FACE_UNLOCK := true

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-motorola

# Quick tap
TARGET_SUPPORTS_QUICK_TAP := true

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# VARIABLE - SePolicy Camera Script
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)
