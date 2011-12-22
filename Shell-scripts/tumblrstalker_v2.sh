#!/bin/bash

#detect and enter tumblr dir
if [ -d ~/tumblr ]
   then
      cd ~/tumblr
else
   mkdir ~/tumblr
   cd ~/tumblr
fi

#get log in info
read -p "Tumblr login email: " EMAIL

read -p "Tumblr login password: " PASSWRD

#log in to get cookies for later
wget --user-agent=Mozilla/5.0 -q --save-cookies tumblr_cookie.txt --post-data "email=$EMAIL&password=$PASSWRD" --no-check-certificate https://www.tumblr.com/login

rm login

#get ids from dash
wget --user-agent=Mozilla/5.0 -q --load-cookies ~/tumblr/tumblr_cookie.txt --no-check-certificate http://www.tumblr.com/dashboard -O -|grep 'src='|cut -d\= -f2 -s|cut -d\" -f2 -s|cut -d\( -f2|grep 'tumblr_l'|cut -d\l --fields 4-100| while read LINK

#download images from ids
do
   echo "Downloading $LINK"
   wget -q -nc "http://media.tumblr.com/tumblr_l$LINK"
done
