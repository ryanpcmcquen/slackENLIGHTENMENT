#!/bin/sh

# Ryan P. C. McQuen | Everett, WA

# This is where all the compilation and final results will be placed
TMP=${TMP:-/tmp}

# This is the original directory where you started this script
ROOT=$(pwd)

sbo_pkg_install() {
  SBO_PACKAGE=$1
  if [ -z "`find /var/log/packages/ -name $SBO_PACKAGE-*`" ]; then
    ## `echo p` fixes sqg confusion
    echo p | sbopkg -B -e stop -i $SBO_PACKAGE
  fi
}

sbopkg -r
## grab these from SBo
sbo_pkg_install lua
sbo_pkg_install luajit
sbo_pkg_install bullet

# get source balls
sh download.sh

# Loop for all packages:
for dir in \
  scim \
  efl \
  python-efl \
  enlightenment \
  terminology \
  ephoto \
  rage \
  ; do
  # get the package name
  package=$(echo $dir | cut -f2- -d /) 
  
  # Change to package directory
  cd $ROOT/$dir || exit 1 

  # Get the version
  version=$(grep "VERSION=" ${package}.info | cut -d "=" -f2 | rev | cut -c 2- | rev | cut -c 2-)

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

if [ -z "$(grep sEL /etc/slackpkg/blacklist)" ]; then
  echo [0-9]+sEL >> /etc/slackpkg/blacklist
fi

echo
echo
echo "*------------------------------*"
echo "You are ready to be ENLIGHTENED!"
echo "*------------------------------*"
echo
echo


