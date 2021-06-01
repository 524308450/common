#!/bin/sh

#工作目录
dir=/var/opt/gitlab

#备份目录
backup_dir=/data/data_backup/git_data_backup

#备份当前日期
backup_date=`date +%F`

#备份周期
backup_week_day=7

#备份日期
backup_date_count=`date -d "-$backup_week_day day" +%F`

#删除过期的备份数据
rm -rf $backup_dir/$backup_date_count

sleep 5
echo `date +"%F %H:%M:%S"`"开始备份今天的Git数据" >> $backup_dir/log

echo "执行备份命令：gitlab-rake gitlab:backup:create"
gitlab-rake gitlab:backup:create
echo `date +"%F %H:%M:%S"`"结束备份今天的Git数据" >> $backup_dir/log

#创建备份目录
mkdir -p $backup_dir/$backup_date

echo `date +"%F %H:%M:%S"`"移动数据文件到指定位置" >> $dir/log

#移动备份文件
mv $dir/backups/* $backup_dir/$backup_date/

echo "查看备份今天的Git数据的大小为：" `du -sh $backup_dir/$backup_date` >> $backup_dir/log