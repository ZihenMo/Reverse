THEOS_DEVICE_IP = iOSIP

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HookerTweak

ARCHS = arm64 
TARGET = iphone:10.0:10.0

HookerTweak_FILES = Tweak.x
HookerTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
#安装后重启
after-install::
	install.exec "killall -9 ReverseTarget"