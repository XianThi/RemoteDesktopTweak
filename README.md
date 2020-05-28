# RemoteDesktopTweak
Communicate pc&amp;phone in tcp stream with server and client sides. Obj-c tweak for ios &amp; c# server for windows.

## Logic
XianThiDesktopServer listening 2525 port on local device and waiting for tcp connections. It will be using rules when the connection succesfully.
XianThiDesktop tweak searching LAN devices on network and trying to connect 2525 port on choose. If its valid, the operations will begin.

## Instruction
You need to compile MMLANSCAN framework for the firstly. Its necessary for XianThiDesktop tweak to searching lan devices.
Compile and install XianThiDesktop tweak for iOS device.
Compile and run XianThiDesktopServer for Windows device.
Test it.
