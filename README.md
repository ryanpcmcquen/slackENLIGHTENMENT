Finally! E19 for Slackware!

Thanks to willysr and GArik for all their work on builds.

I've made what I like to call a 'greatest hits' of their work.

We have the standard SBo style here thanks to Willy! These scripts are nearly a blatant copy of his work (with the ```sEL``` tag), and an automatic build script that gets the dependencies using sbopkg. 
I have also added some configure flags and explicitly set MAKEFLAGS.

Simply run:

    sh enlighten-me.sh

And all the source tarballs will be downloaded, built and installed. Note that pulseaudio will be installed and configured. You can modify efl with ```--disable-pulseaudio``` but then you will NOT have sound. Read *pulseaudio-warning* to learn more.

Any dependencies will be grabbed with ```sbopkg``` so make sure you have it!

Enjoy!


Complete Build Order :
- efl
- e_dbus
- elementary
- evas-generic-loaders
- emotion-generic-players
- terminology
- python-efl
- econnman
- enlightenment

The script will automatically add ```[0-9]+sEL``` to /etc/slackpkg/blacklist, so the packages won't be removed when you run ```slackpkg clean-system```.

Enjoy!

Note:
You will need to remove all ```sEL``` packages before installing/upgrading to a newer version to ensure that all libraries all linked to the proper version.
