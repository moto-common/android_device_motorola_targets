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

# Inherit some common Rising OSS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## RisingOSS Flags
WITH_GMS := true  # (For gapps build, but dont use it alone as of now, since u will get magnified setup page, so not advisable)
TARGET_CORE_GMS := true  # (for core gapps build, use along with above flag, u wont have setup wizard though)
TARGET_USE_PIXEL_FINGERPRINT := true
TARGET_OPTOUT_GOOGLE_TELEPHONY := false
TARGET_SUPPORTS_NEXT_GEN_ASSISTANT := true
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_HAS_UDFPS := false
TARGET_ENABLE_BLUR := false
RISING_PACKAGE_TYPE := Gapps

# Cameras
TARGET_BUILD_GRAPHENEOS_CAMERA := true
TARGET_BUILD_APERTURE_CAMERA := false

# Maintainer
RISING_MAINTAINER := PizzaG

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/source.mk)

# Required Scripts
$(warning This ROM requires replace_camera_sepolicy.sh to be ran...)

PRODUCT_NAME := rising_$(DEVICE)

