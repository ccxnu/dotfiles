slock - simple screen locker
============================
simple screen locker utility for X.


Requirements
------------
In order to build slock you need the Xlib header files.
Make sure to change the default font in 'config.h' file.

Installation
------------
Edit config.mk to match your local setup (slock is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install slock
(if necessary as root):

    make clean install


Running slock
-------------
Simply invoke the 'slock' command. To get out of it, enter your password.


Patches
-------------
- [Message](https://tools.suckless.org/slock/patches/message/): Add a message to your lock screen.
- [Transparency](https://github.com/khuedoan/slock/commit/5e7a95b50fd72efcf2a40d487278749a17cbb146): Add alpha to change transparency.
- [Xft Font](https://github.com/nathanielevan/slock/commit/26b565923ab1ff5e55669ad092f87cf96c231211): Add support for Xft font support.
