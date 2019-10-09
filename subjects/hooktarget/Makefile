THEOS_DEVICE_IP = iOSIP
include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = HookTarget

HookTarget_FILES = main.m MZAppDelegate.m MZRootViewController.mm
HookTarget_FRAMEWORKS = UIKit CoreGraphics
HookTarget_CFLAGS = -fobjc-arc

ARCHS = arm64 
TARGET = iphone:10.0:10.0

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "su mobile -c uicache"
