include $(THEOS)/makefiles/common.mk
export ARCHS=arm64
export TARGET := iphone:11.2

APPLICATION_NAME = XianThiDesktop
ADDITIONAL_CFLAGS = -fobjc-arc
XianThiDesktop_FILES = main.m ProcessCell.m DeviceCell.m Communicator.m RemoteDesktopController.m XiaAppDelegate.m XiaRootViewController.m
XianThiDesktop_FRAMEWORKS = UIKit CoreGraphics
XianThiDesktop_EXTRA_FRAMEWORKS = MMLanScan

XianThiDesktop_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"XianThiDesktop\"" || true
