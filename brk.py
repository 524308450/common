#!/usr/bin/python
# -*- coding: UTF-8 -*-

###break语句用来终止循环语句，即循环条件没有False条件或者序列还没被完全递归完，也会停止执行循环语句
###如果您使用嵌套循环，break语句将停止执行最深层的循环，并开始执行下一行代码

for i in 'Python':
 if i == 'h':
  break
 print '当前字母 :', i


var = 10
while var > 0:
 var = var -1
 if var == 5:
  break
 print '当前变量值 :', var

print "Good Bye!"
"""
打印结果如下：
当前字母 : P
当前字母 : y
当前字母 : t
当前变量值 : 9
当前变量值 : 8
当前变量值 : 7
当前变量值 : 6
Good Bye!
"""
