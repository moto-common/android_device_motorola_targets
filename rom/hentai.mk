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

# All components inherited here go to product image
$(call inherit-product, vendor/hentai/build/product/hentai_product.mk)

# Kernel
$(call inherit-product, device/motorola/targets/include/kernel/prebuilt.mk)

# Hentai Required Packages
PRODUCT_PACKAGES += libtensorflowlite_jni

# Hentai Official Rel Extras
$(call inherit-product-if-exists, vendor/hentai-priv/hentai-priv.mk)

PRODUCT_NAME := hentai_$(DEVICE)
