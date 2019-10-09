
#iOS ip地址 采用~/.ssh/config 别名的方式可使用usb映射的端口
THEOS_DEVICE_IP = iOSIP
INSTALL_TARGET_PROCESSES = StpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iOSReverse

#编译源文件，可按需添加
iOSReverse_FILES = Tweak.xm	
iOSReverse_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

#指定架构

ARCHS = arm64 
TARGET = iphone:10.0:10.0

#导入框架 以空格分隔
iOSREProject_FRAMEWORKS = UIKit

#私有框架
iOSREProject_PRIVATE_FRAMEWORKS = AppSupport ChatKit IMCore

#链接Mach-O库
#iOSREProject_LDFLAGS = -lx #表示libx.dylib

#安装后重启
after-install::
	install.exec "killall -9 SpringBoard"