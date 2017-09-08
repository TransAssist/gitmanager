#!/usr/bin/env bash
if [ -z "${LOCAL_BIN+x}" ] ; then
 echo "require \$LOCAL_BIN"
 exit
fi
INSTALL=$LOCAL_BIN/gitmanager
rm -f $INSTALL
ln -s $(pwd)/gitmanager $INSTALL
