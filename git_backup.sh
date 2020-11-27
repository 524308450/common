 #!/bin/sh
h=/var/opt/gitlab
echo `date +"%F %H:%M:%S"`"开始删除昨天备份的Git数据" >> $h/log
rm -rf /var/opt/gitlab/backups/*
echo `date +"%F %H:%M:%S"`"结束删除昨天备份的Git数据" >> $h/log
sleep 5
echo `date +"%F %H:%M:%S"`"开始备份今天的Git数据" >> $h/log
echo "执行备份命令：gitlab-rake gitlab:backup:create"
gitlab-rake gitlab:backup:create
echo `date +"%F %H:%M:%S"`"结束备份今天的Git数据" >> $h/log
echo "查看备份今天的Git数据的大小为：" `du -sh $h/backups` >> $h/log