#!/bin/bash

# mysql用户名
user=root

# mysql密码
password=pwd@123

# mysql配置文件
mysql_conf_file=/etc/my.cnf

# 备份路径
backup_dir=/xtrabackup

#备份压缩前缀
backup_tar_mysql=mysql_backup

# 压缩备份路径
backup_tar_dir=/data

# 全备是在一周的第几天
full_backup_week_day=7

# 全量备份信息名称 前缀
full_backup=full

# 增量备份信息名称 前缀
increment_backup=incr

# 备份日期
backup_date=`date +%F`

# 备份日期
backup_week_day=`date +%u`

# 判断是应该全备还是增量备份
# 0:full, 1:incr
function get_backup_type() {
  if [ "$full_backup_week_day" -eq `date +%u` ]; then
    backup_type=0
  else
    backup_type=1
  fi
  return $backup_type
}

# 全量备份
function full_backup() {
  
  backup_folder=${full_backup}_${backup_date}
     
  mkdir -p $backup_dir/$backup_folder
  xtrabackup \
    --defaults-file=$mysql_conf_file \
    --user=$user \
    --password=$password \
    --parallel=2 \
    --no-lock \
    --safe-slave-backup \
    --backup \
    --target-dir=$backup_dir/$backup_folder

  return $?
}


# 差异备份
function increment_backup() {

  incr_base_folder=${increment_backup}_${backup_date} 
  mkdir -p $backup_dir/$incr_base_folder

  if [ `date +%u` -eq 1 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-1 day" +%F`
  elif [ `date +%u` -eq 2 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-2 day" +%F`
  elif [ `date +%u` -eq 3 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-3 day" +%F`
  elif [ `date +%u` -eq 4 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-4 day" +%F`
  elif [ `date +%u` -eq 5 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-5 day" +%F`
  elif [ `date +%u` -eq 6 ]; then
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_`date -d "-6 day" +%F`
  fi
  return $?
}


# 删除之前的备份(一般在全备完成后使用)
function delete_before_backup() {
  #rm -rf $backup_dir/${full_backup}_`date -d "-7 day" +%F`
  rm -rf $backup_dir/*
}

# 将之前备份的数据打包、压缩
function backup_tar() {
  if [ ! -d $backup_tar_dir ]; then

    mkdir -p $backup_tar_dir

  fi

  tar -zcf $backup_tar_dir/${backup_tar_mysql}_${backup_date}.tar.gz $backup_dir/*
}


function run() {

  #判断备份类型：全量或增量
  get_backup_type
  backup_type=$?
  
  case $backup_type in
    0 )
      
      #全量备份之前，先打包备份之前的数据
      if [ ! "ls -A $backup_dir" == ""  ]; then
        echo "$backup_dir  目录不为空"
        backup_tar
      #打包之后，删除工作目录下备份信息
        delete_before_backup
      else
        echo "$backup_dir  目录为空"
      fi
      sleep 10
      #执行全量备份
      full_backup
      backup_ok=$?
      ;;
    1 )
      
      #差异备份
      increment_backup  
      backup_ok=$?
      ;;
  esac
}

#运行备份
run