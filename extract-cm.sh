#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
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

DEVICE=galaxys2
COMMON=c1-common
MANUFACTURER=samsung

BASE_PROPRIETARY_COMMON_DIR=vendor/$MANUFACTURER/$COMMON/proprietary
PROPRIETARY_DEVICE_DIR=../../../vendor/$MANUFACTURER/$DEVICE/proprietary
PROPRIETARY_COMMON_DIR=../../../$BASE_PROPRIETARY_COMMON_DIR

CM_DOWNLOAD_SITE=http://download.cyanogenmod.com/get
CM_IMAGE=update-cm-7.1.0-GalaxyS2-signed.zip
CM_ROOT=cm_root

# copy_cm_files
# pulls a list of files from the CyanogenMod and adds the files to the list of blobs
#
# $1 = list of files
# $2 = directory path on device
# $3 = directory name in $PROPRIETARY_COMMON_DIR
copy_cm_files()
{
    for NAME in $1
    do
        echo Copying \"$NAME\"
        cp $CM_ROOT/$2/$NAME $PROPRIETARY_COMMON_DIR/$3/$NAME
    done
}

# Download CyanogenMod image

echo Downloading CyanogenMod image $CM_IMAGE ...
if [ -f $CM_IMAGE ]; then
  echo Image $CM_IMAGE exists, skip downloading
else
  wget $CM_DOWNLOAD_SITE/$CM_IMAGE
fi

# Extracting binary blobs from CyanogenMod image

unzip -q $CM_IMAGE -d $CM_ROOT

COMMON_LIBS="
	"
copy_cm_files "$COMMON_LIBS" "system/lib" ""

COMMON_CAMERADATA="
	"
copy_cm_files "$COMMON_CAMERADATA" "system/cameradata" "cameradata"

COMMON_EGL="
	"
copy_cm_files "$COMMON_EGL" "system/lib/egl" "egl"

COMMON_FIRMWARE="
	"
copy_cm_files "$COMMON_FIRMWARE" "system/etc/firmware" "firmware"

COMMON_HW="
	"
copy_cm_files "$COMMON_HW" "system/lib/hw" "hw"

COMMON_KEYCHARS="
	"
copy_cm_files "$COMMON_KEYCHARS" "system/usr/keychars" "keychars"

COMMON_WIFI="
  "
copy_cm_files "$COMMON_WIFI_LIBS" "system/lib" "wifi"

COMMON_WIFI_LIBS="
	"
copy_cm_files "$COMMON_WIFI_LIBS" "system/lib" "wifi"

COMMON_AUDIO="
	libaudiopolicy.so
	"
copy_cm_files "$COMMON_AUDIO" "system/lib" "audio"

rm -rf $CM_ROOT
#rm $CM_IMAGE

