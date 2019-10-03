#!/bin/sh

LOG_DIR=/var/log/nginx
APPEND=$( date -d "yesterday 13:00 " '+%Y-%m-%d' )
ACCESS_LOG=$LOG_DIR/access.log
ACCESS_LOG_ROTATED=$LOG_DIR/access.log.$APPEND
ERROR_LOG=$LOG_DIR/error.log
ERROR_LOG_ROTATED=$LOG_DIR/error.log.$APPEND

if [ -s $ACCESS_LOG ]; then
    mv $ACCESS_LOG $ACCESS_LOG_ROTATED
fi

if [ -s $ERROR_LOG ]; then
    mv $ERROR_LOG $ERROR_LOG_ROTATED
fi

if [ -f $ACCESS_LOG_ROTATED ] || [ -f $ERROR_LOG_ROTATED ]; then
    kill -USR1 `cat /var/run/nginx.pid`
    sleep 1
fi

if [ -f $ACCESS_LOG_ROTATED ]; then
    gzip $ACCESS_LOG_ROTATED
fi

if [ -f $ERROR_LOG_ROTATED ]; then
    gzip $ERROR_LOG_ROTATED
fi
