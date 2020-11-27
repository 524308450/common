#!/bin/bash
h=/var/atlassian/application-data/confluence/backups
if [ "`ls -A $h`" = "" ];then
        echo `date +"%F %H:%M:%S"` "$h是空目录" >> $h/../logs/wiki.log
else
        echo "$h目录下有文件,且文件是:" `ls -A $h` >>$h/../log
        echo `date +"%F %H:%M:%S"` "开始删除文件"`ls -A $h` >>$h/../logs/wiki.log
        rm $h/*
        echo `date +"%F %H:%M:%S"` "开始删除文件" >>$h/../logs/wiki.log
fi