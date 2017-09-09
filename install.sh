#!/usr/bin/env bash
if [ -z "${LOCAL_BIN+x}" ] ; then
 echo "require \$LOCAL_BIN"
 exit
fi
INSTALL=$LOCAL_BIN/wer
rm -f $INSTALL
ln -s $(pwd)/wer.pl $INSTALL

echo "complate"
