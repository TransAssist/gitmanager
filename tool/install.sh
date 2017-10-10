#!/usr/bin/env bash
if [ -z "${BIN+x}" ] ; then
 echo "require env \$LOCAL_BIN"
 exit
fi
INSTALL=$BIN/wer
rm -f $INSTALL
ln -s $(pwd)/wer.pl $INSTALL

echo "complate"
