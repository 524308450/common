#!/usr/bin/env python
#-*-coding:utf-8
import os
import time
import datetime
#定义服务器，用户名、密码、数据库名称（多个库分行放置）和备份的路径
DB_HOST = raw_input('请输入数据库地址：')
DB_USER = raw_input('请输入数据库用户名：')
DB_USER_PASSWD = raw_input('请输入数据库密码：')
DB_NAME = raw_input('请输入需要备份数据库库名：')
BACKUP_PATH = '/home/mysql/'

DATETIME = time.strftime('%Y%m%d-%H%M%S')
TODAYBACKUPPATH = BACKUP_PATH + DATETIME

print("createing backup folder!")
#创建备份文件夹
if not os.path.exists(TODAYBACKUPPATH):
        os.makedirs(TODAYBACKUPPATH)

print("checking for databases names file")
time.sleep(3)

#定义执行备份脚本，读取文件中的数据库名称，注意按行读写，不校验是否存在该库
dumpcmd = "mysqldump -u" +DB_USER + " -p"+DB_USER_PASSWD+" " +DB_NAME+" > "+TODAYBACKUPPATH +"/"+DB_NAME+".sql"
print(dumpcmd)
time.sleep(3)
os.system(dumpcmd)
#执行压缩的函数
def run_tar():
        compress_file = TODAYBACKUPPATH + ".tar.gz"
        compress_cmd = "tar -czvf " +compress_file+" "+DATETIME
        os.chdir(BACKUP_PATH)
        os.system("pwd")
        os.system(compress_cmd)
        print("compress complete!")
        #删除备份文件夹
        remove_cmd = "rm -rf "+TODAYBACKUPPATH
        os.system(remove_cmd)

#备份数据库文件存在就执行备份和压缩，否则退出
if os.path.exists(TODAYBACKUPPATH):
        run_tar()
        print("备份成功!")
else:
        print("备份失败...")
        exit()