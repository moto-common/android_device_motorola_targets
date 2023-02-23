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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/prebuilt.mk)

# NoNearbySharingOverlay
PRODUCT_PACKAGES += \
    NoNearbySharingOverlay

# Avoid double inclusion
ROM_INCLUDES_QCOM_COMMON := true

# Bluetooth
PRODUCT_SOONG_NAMESPACES += \
    packages/modules/Bluetooth/android/app
