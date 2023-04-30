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

# Inherit some common lmodroid stuff.
$(call inherit-product, vendor/lmodroid/config/common_full_phone.mk)

# Face Unlock isn't ready yet
TARGET_FACE_UNLOCK_OPTOUT := true

# GMS
GMS_MAKEFILE := gms_64bit_only.mk
WITH_GMS_FEATURE := true
WITH_GMS := true

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# Libhidl
PLATFORM_PROVIDES_LIBHIDL := true

# Required Scripts
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)

PRODUCT_NAME := lmodroid_$(DEVICE)
