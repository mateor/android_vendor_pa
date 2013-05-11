# Copyright (C) 2012 ParanoidAndroid Project
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

# Check for target product
ifeq (pa_encore,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_encore

# Build paprefs from sources
PREFS_FROM_SOURCE ?= false

# Include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# Inherit AOSP device configuration
$(call inherit-product, device/bn/encore/full_encore.mk)

# Product Package Extras - Repos can be added manually or via addprojects.py
-include vendor/pa/packages/encore.mk

# CM Package Extras
-include vendor/pa/packages/cm.mk

# Override AOSP build properties
PRODUCT_NAME := pa_encore
PRODUCT_BRAND := bn
PRODUCT_MODEL := NookColor
PRODUCT_MANUFACTURER := bn
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=encore BUILD_ID=JDQ39 BUILD_DISPLAY_ID=JDQ39 BUILD_FINGERPRINT="bn/bn_encore/encore:4.2.2/JDQ39/573038:user/release-keys" PRIVATE_BUILD_DESC="encore-user 4.2.2 JDQ39 573038 release-keys"

# Update local_manifest.xml
GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))
GET_PROJECT_RMS := $(shell vendor/pa/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pa/tools/addprojects.py $(PRODUCT_NAME))
GET_CM_PROJECT_ADDS := $(shell vendor/pa/tools/addprojects.py cm.adds)

# Hack needed for Nook Color's sdcard-installer script. It has been in use for too many years to expect change. I am not happy about it either.
PRODUCT_VERSION_MAJOR := 10.1
CM_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.version = $(CM_VERSION)

# ParanoidAndroid for Nook Color Goo Manager update parameters (DEV_VER set so as to override pa_common.mk

DEVELOPER_VERSION := true
PRODUCT_PROPERTY_OVERRIDES += \
  ro.goo.developerid=mateor \
  ro.goo.rom=pa_encore \
  ro.goo.version=$(shell date +%s)
endif
