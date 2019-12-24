#!/usr/bin/env python
#-*-coding:utf-8

import os,shutil,datetime,sys

root_path = r'/mnt/'

for item in os.walk(root_path):
    print(item)
