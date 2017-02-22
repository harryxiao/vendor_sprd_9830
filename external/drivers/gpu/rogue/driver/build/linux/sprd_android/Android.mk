LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := pvrsrvkm.ko
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_RELATIVE_PATH := modules
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

$(warning LOCAL_MODULE: $(LOCAL_MODULE))
$(warning LOCAL_PATH: $(LOCAL_PATH))
$(warning PLATFORM_VERSION: $(PLATFORM_VERSION))
$(warning PLATFORM_VERSION_CODENAME: $(PLATFORM_VERSION_CODENAME))

ifeq ($(TARGET_BUILD_VARIANT),user)
  BUILD_ := release
else
  BUILD_ := debug
endif

$(warning TARGET_ARCH: $(TARGET_ARCH))
ifeq ($(TARGET_ARCH),x86_64)
ARCH_ := x86_64
CROSS_COMPILE_ := x86_64-linux-android-
RGX_NOHW_ := 0
endif

$(LOCAL_PATH)/pvrsrvkm.ko : $(TARGET_PREBUILT_KERNEL)
	$(MAKE) -C $(shell dirname $@) ARCH=$(ARCH_) CROSS_COMPILE=$(CROSS_COMPILE_) BUILD=$(BUILD_) PLATFORM_VERSION=$(PLATFORM_VERSION) PLATFORM_VERSION_CODENAME=$(PLATFORM_VERSION_CODENAME) RGX_NOHW=$(RGX_NOHW_) clean
	$(MAKE) -C $(shell dirname $@) ARCH=$(ARCH_) CROSS_COMPILE=$(CROSS_COMPILE_) BUILD=$(BUILD_) PLATFORM_VERSION=$(PLATFORM_VERSION) PLATFORM_VERSION_CODENAME=$(PLATFORM_VERSION_CODENAME)  RGX_NOHW=$(RGX_NOHW_)
	cp -r $(OUT)/target_x86_64/kbuild/pvrsrvkm.ko $(shell dirname $@)
