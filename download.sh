#!/bin/sh

ARCH=$(uname -m)
PKGS=$(find -type f -name '*.info' -exec basename {} .info \;)

##checksum()
##{
##  sum=$(md5sum $1 | cut -d ' ' -f1)
##
##  if [ "$sum" != "$2" ]; then
##    echo ""
##    echo "WARNING: checksum failed: $1"
##    echo ""
##
##    sleep 2
##  fi
##}

for pkg in $PKGS; do
  . $pkg/$pkg.info

  if [ "$ARCH" = "x86_64" ]; then
    case $pkg in
      *)
        DOWNLOAD=$(echo $DOWNLOAD | cut -d ' ' -f2-)
        DOWNLOAD="$DOWNLOAD $DOWNLOAD_x86_64"
        MD5SUM=$(echo $MD5SUM | cut -d ' ' -f2-)
        MD5SUM="$MD5SUM $MD5SUM_x86_64"
        ;;
    esac
  fi

  DOWNLOAD=($DOWNLOAD)
  MD5SUM=($MD5SUM)

  len=${#DOWNLOAD[@]}

  for (( i=0; i < $len; i++ )); do
    src=$(basename ${DOWNLOAD[$i]})

    echo $DOWNLOAD | grep -qi "github.com"

    if [ "$?" = "0" ]; then
      ext=$(echo $src | rev | cut -d. -f1-2 | rev)
      src=$PRGNAM-$VERSION.$ext
    fi

    if [ -e "$pkg/$src" ]; then
      continue;
    fi

    file=$(cd $pkg; find ../ -type f -name $src)

    if [ -z "$file" ]; then
      wget -O $pkg/$src ${DOWNLOAD[$i]}
    else
      ln -sf $file $pkg
    fi
  done
done
