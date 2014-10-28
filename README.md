Finally! E19 for Slackware!

Thanks to willysr and GArik for all their work on builds.

I've made what I like to call a 'greatest hits' of their work.

We have the standard SBo style here thanks to Willy! 


I've made the script automatic so all you have to is run:

    sh enlighten-me.sh

And all the source tarballs will be downloaded, built and installed.

Any dependencies will be grabbed with ```sbopkg``` so make sure you have it!

Enjoy!


Complete Build Order :
- efl
- elementary
- evas-generic-loaders
- emotion-generic-players
- terminology
- python-efl
- econnman
- enlightenment

Note:
You will need to remove all packages before installing/upgrading
to a newer version to ensure that all libraries all linked to the
proper version.
