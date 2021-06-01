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

#备份数据
function backup_data() {

 printf "###############$backup_date日开始执行备份###############\n" >> $backup_dir/log
 echo `date +"%F %H:%M:%S"`"开始备份今天的Git数据" >> $backup_dir/log
 
 #执行备份
 printf "\n"
 { time gitlab-rake gitlab:backup:create ; } 2>> $backup_dir/log

 echo `date +"%F %H:%M:%S"`"结束备份今天的Git数据" >> $backup_dir/log
 
 printf "\n"

 #创建备份目录
 if [[ ! -d "$backup_dir/$backup_date" ]];then
   printf "备份: $backup_dir/$backup_date 目录不存在\n" >> $backup_dir/log
   printf "创建备份目录:$backup_dir/$backup_date \n" >> $backup_dir/log
   mkdir -p $backup_dir/$backup_date
 else
   printf "备份目录已存在\n" >> $backup_dir/log
 fi

 #移动备份文件
 mv $dir/backups/* $backup_dir/$backup_date/

 data_size=`du -sh $backup_dir/$backup_date`
 printf "查看备份今天的Git数据的大小为: $data_size \n" >> $backup_dir/log

}

function delete_backup_data() {

 printf "删除过期的备份数据:$backup_dir/$backup_date_count \n" >>$backup_dir/log
 rm -rf $backup_dir/$backup_date_count
 printf "###############$backup_date###############\n" >> $backup_dir/log
 printf "\n" >> $backup_dir/log

}

backup_data
delete_backup_data