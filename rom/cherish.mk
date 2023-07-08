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

# Inherit some common CherishOS Stuff.
$(call inherit-product, vendor/cherish/config/common.mk)

# CherishOS Stuff with GApps
TARGET_SUPPORTS_GOOGLE_RECORDER := true
TARGET_BUILD_GRAPHENEOS_CAMERA := false
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_ENABLE_BLUR := false
WITH_GMS := true

# FOD animations
EXTRA_UDFPS_ANIMATIONS := false

# Maintainer Stuff
CHERISH_BUILD_TYPE := UNOFFICIAL
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.cherish.maintainer=

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# VARIABLE - SePolicy Camera Script
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)

PRODUCT_NAME := cherish_$(DEVICE)
