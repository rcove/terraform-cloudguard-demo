#!/bin/bash
# This shell script will run until the url succesfully downloads 
date
until curl \
    --url http://siac-demo.mycloudguard.net./CloudGuard.png ; do
     sleep 5
done
date
