Finally! A cutting edge Enlightenment for Slackware!

Thanks to willysr and GArik for all their work on builds.

I've made what I like to call a 'greatest hits' of their work.

We have the standard SBo style here thanks to Willy and some reduced dependencies thanks to GArik! These scripts are nearly a blatant copy of his work (with the ```sEL``` tag), and an automatic build script that gets the dependencies using sbopkg. 
I have also added some configure flags and explicitly set MAKEFLAGS where necessary.

## WARNING: 14.2 is no longer supported!!!

Simply run:

    git clone https://github.com/ryanpcmcquen/slackENLIGHTENMENT.git
    cd slackENLIGHTENMENT/
    sh enlighten-me.sh

All the tarballs will be downloaded, built and installed.  Pulseaudio is no longer part of the build, and sound works in Firefox, Chromium, Spotify and Steam. The only thing you are losing out on is Enlightenment's interface sounds.

Any dependencies will be grabbed with ```sbopkg``` so make sure you have it!

Enjoy!


Complete Build Order :
- efl
- terminology
- python-efl
- enlightenment

The script will automatically add ```[0-9]+sEL``` to /etc/slackpkg/blacklist, so the packages won't be removed when you run ```slackpkg clean-system```.

Enjoy!

Note:
You will need to remove all ```sEL``` packages before installing/upgrading to a newer version to ensure that all libraries are linked to the proper version.
