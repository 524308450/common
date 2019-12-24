#!/usr/bin/env python
#-*-coding:utf-8

import os,shutil,datetime,sys

root_path = r'/mnt/'

for item in os.walk(root_path):
    print(item)

#拼接文件路径
for base_path,folder_list,file_list in os.walk(root_path):
 for file_names in file_list:
  file_path = os.path.join(base_path,file_names)
  print(file_path)
