THEOS_DEVICE_IP = iOSIP

INSTALL_TARGET_PROCESSES = HookTarget

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HookTweak

ARCHS = arm64 
TARGET = iphone:latest:10.0

HookTweak_FILES = Tweak.xm
HookTweak_CFLAGS = -fobjc-arc

iOSREProject_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
