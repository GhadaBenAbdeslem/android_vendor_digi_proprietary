-include $(TOPDIR)frameworks/opt/digiservices/src_available.mk

ifneq ($(DIGI_SERVICES_SRC_AVAILABLE),true)

LOCAL_PATH := $(call my-dir)

# Copy libdigiservices.so to /system/lib/
include $(CLEAR_VARS)
LOCAL_MODULE := libdigiservices
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_32 := $(LOCAL_MODULE)-arm32$(LOCAL_MODULE_SUFFIX)
LOCAL_SRC_FILES_64 := $(LOCAL_MODULE)-arm64$(LOCAL_MODULE_SUFFIX)
include $(BUILD_PREBUILT)

# Build digiservices.jar from the static library
include $(CLEAR_VARS)
LOCAL_MODULE := digiservices
LOCAL_REQUIRED_MODULES := services RXTXcomm CloudConnectorAndroid
LOCAL_STATIC_JAVA_LIBRARIES := staticdigiservices
include $(BUILD_JAVA_LIBRARY)
include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := staticdigiservices:digiservices.jar
include $(BUILD_MULTI_PREBUILT)

# Copy digiservices.xml to /system/etc/permissions/
include $(CLEAR_VARS)
LOCAL_MODULE := digiservices.xml
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/permissions
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# Copy libdiginativeservice.so to /system/lib/
include $(CLEAR_VARS)
LOCAL_MODULE := libdiginativeservice
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := libsocketcan
LOCAL_SRC_FILES_32 := $(LOCAL_MODULE)-arm32$(LOCAL_MODULE_SUFFIX)
LOCAL_SRC_FILES_64 := $(LOCAL_MODULE)-arm64$(LOCAL_MODULE_SUFFIX)
include $(BUILD_PREBUILT)

# Copy diginativeservice to /system/bin/
include $(CLEAR_VARS)
LOCAL_MODULE := diginativeservice
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := both
LOCAL_REQUIRED_MODULES := \
    libdiginativeservice \
    diginativeservice.rc
LOCAL_SRC_FILES_32 := $(LOCAL_MODULE)32
LOCAL_SRC_FILES_64 := $(LOCAL_MODULE)64
LOCAL_MODULE_STEM_32 := $(LOCAL_MODULE)32
LOCAL_MODULE_STEM_64 := $(LOCAL_MODULE)64
include $(BUILD_PREBUILT)
include $(BUILD_SYSTEM)/executable_prefer_symlink.mk

# Copy diginativeservice.rc to /system/etc/init
include $(CLEAR_VARS)
LOCAL_MODULE := diginativeservice.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/init
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

endif
