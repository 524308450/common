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

# 备份日期
backup_date_count=`date -d "-$backup_week_day day" +%F`

# 判断是应该全备还是增量备份
# 0:full, 1:incr
function get_backup_type() {

  if [[ ! -d ${backup_dir}/${full_backup}_${backup_date_count} ]] || [[ "$full_backup_week_day" -eq "$backup_week_day" ]]; then
    backup_type=0
  else
    backup_type=1
  fi

  return $backup_type
}

# 全量备份
function full_backup() {

  if [[ ! -d ${backup_dir}/${full_backup}_${backup_date_count} ]] && [[ "$full_backup_week_day" -eq "$backup_week_day" ]]; then
    backup_folder=${full_backup}_${backup_date}
  else
    backup_folder=${full_backup}_${backup_date_count}
  fi
     
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
    
    xtrabackup \
      --defaults-file=$mysql_conf_file \
      --user=$user \
      --password=$password \
      --no-lock \
      --backup \
      --target-dir=$backup_dir/$incr_base_folder \
      --incremental-dir=$backup_dir/${full_backup}_${backup_date_count}

  return $?
}


# 删除之前的备份(一般在全备完成后使用)
function delete_before_backup() {
  #rm -rf $backup_dir/${full_backup}_`date -d "-7 day" +%F`
  rm -rf $backup_dir/*
}

# 将之前备份的数据打包、压缩
function backup_tar() {

    mkdir -p $backup_tar_dir
    tar -zcf $backup_tar_dir/${backup_tar_mysql}_${backup_date}.tar.gz $backup_dir/*
}


function run() {

  #判断备份类型：全量或增量
  get_backup_type
  backup_type=$?
  
  case $backup_type in
    0 )
      
      #全量备份之前，先打包备份之前的数据
      if [ "`ls -A $backup_dir`" == ""  ]; then

        #执行全量备份
        full_backup
      else
        
        backup_tar
      #打包之后，删除工作目录下备份信息
        delete_before_backup
        full_backup
      fi
      ;;
    1 )
      
      #差异备份
      increment_backup  
      ;;
  esac
}

run