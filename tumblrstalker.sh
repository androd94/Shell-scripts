#!/bin/bash

LINK=""

if [ -d ~/tumblr ]
   then
      cd ~/tumblr
else
   mkdir ~/tumblr
fi

read -p "Tumblr name: " NAME

if [ -d ~/tumblr/$NAME ]
   then
      cd ~/tumblr/$NAME
else
   cd ~/tumblr
   mkdir ~/tumblr/$NAME
   cd ~/tumblr/$NAME
fi

wget -q "http://$NAME.tumblr.com" -O -|grep 'img src'|cut -d\< -f4|cut -d\" -f2 -s|grep 'tumblr_l'|cut -d\l --fields 4-100|while read LINK; do echo "Downloading $LINK";wget -q -c "http://media.tumblr.com/tumblr_l$LINK";done
