# Copyright 2023 The Android Open Source Project
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

# Inherit common Xtended OS  Stuff.
$(call inherit-product, vendor/xtended/config/common_full_phone.mk)

# Xtended Stuffs
XTENDED_BUILD_MAINTAINER := 
XTENDED_BUILD_TYPE := UNOFFICIAL
WITH_GAPPS := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_USES_BLUR := false
TARGET_SHIP_GCAM_GO := true
XTENDED_BUILD_DONATE_URL :=

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# VARIABLE - SePolicy Camera Script
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)
