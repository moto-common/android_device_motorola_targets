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

# APEX
MAINLINE_INCLUDE_ART_MODULE := false
MAINLINE_INCLUDE_BT_MODULE := false

# Includes
include device/motorola/targets/devices/rhodei/rhodei.mk
include device/motorola/targets/rom/hentai.mk

# Device Model
PRODUCT_MODEL := moto g stylus 2022 5g (hOS)
PRODUCT_NAME := hentai_rhodei
