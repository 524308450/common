#!/usr/bin/env python
#-*-coding:utf-8

import os,shutil,datetime,sys

root_path = r'/mnt/'

for item in os.walk(root_path):
    print(item)

#拼接文件路径,python2.7下,不能使用maxspli参数
total_num = 0
for base_path,folder_list,file_list in os.walk(root_path):
 for file_names in file_list:
  file_path = os.path.join(base_path,file_names)
  file_ext = file_path.rsplit('.',1)
#  print file_path
#  print file_ext
#  print len(file_ext)
  if len(file_ext) != 2:
    continue
  if file_ext[1] != 'py':
    continue
#  print file_ext
  file_num = 0
  with open(file_path,'rb') as f:
    for line in f:
     ###过滤掉空行
     line = line.strip()
     if not line:
      continue
     ###过滤掉#开头的
     if line.startswith(b'#'):
      continue
     file_num += 1
#   print file_num
  total_num += file_num
  print(file_num,file_path)
  print(total_num)
