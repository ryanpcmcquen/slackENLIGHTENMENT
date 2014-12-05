#!/bin/sh

# Ryan P.C. McQuen | Everett, WA | ryan.q@linux.com

# Copyright 2013 Willy Sudiarto Raharjo <willysr@slackware-id.org>
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This is where all the compilation and final results will be placed
TMP=${TMP:-/tmp}

# This is the original directory where you started this script
ROOT=$(pwd)

sbo_pkg_install() {
  SBO_PACKAGE=$1
  if [ ! -e /var/log/packages/$SBO_PACKAGE-* ]; then
    ## fix for sqg confusion
    echo p | sbopkg -B -i $SBO_PACKAGE
  fi
}

sbopkg -r
## grab these from SBo
sbo_pkg_install lua
sbo_pkg_install luajit
sbo_pkg_install bullet
sbo_pkg_install libwebp
sbo_pkg_install orc
sbo_pkg_install gstreamer1
sbo_pkg_install gst1-plugins-base

## explicitly set MAKEFLAGS, otherwise builds will fail
export MAKEFLAGS=-j1

# get source balls
sh download.sh

# Loop for all packages
for dir in \
  efl \
  e_dbus \
  elementary \
  evas-generic-loaders \
  emotion-generic-players \
  terminology \
  python-efl \
  enlightenment \
  ; do
  # get the package name
  package=$(echo $dir | cut -f2- -d /) 
  
  # Change to package directory
  cd $ROOT/$dir || exit 1 

  # Get the version
  version=$(cat ${package}.info | grep "VERSION=" | cut -d "=" -f2 | rev | cut -c 2- | rev | cut -c 2-)

  # The real build starts here
  sh ${package}.SlackBuild || exit 1
  PACKAGE="${package}-$version-*sEL.txz"
  if [ -f $TMP/$PACKAGE ]; then
    upgradepkg --install-new --reinstall $TMP/$PACKAGE
  else
    echo "Error:  package to upgrade "$PACKAGE" not found in $TMP"
    exit 1
  fi
  
  # back to original directory
  cd $ROOT
done

if [ -z "$( cat /etc/slackpkg/blacklist | grep [0-9]+sEL )" ]; then
  echo [0-9]+sEL >> /etc/slackpkg/blacklist
fi

echo
echo
echo "*------------------------------*"
echo "You are ready to be ENLIGHTENED!"
echo "*------------------------------*"
echo
echo


