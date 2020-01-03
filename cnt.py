#!/usr/bin/python
# -*- coding: UTF-8 -*-

###continue 语句跳出本次循环，而break跳出整个循环###
###continue 语句用来告诉Python跳过当前循环的剩余语句，然后继续进行下一轮循环###

for i in 'Python':
 if i == 'h':
  continue
 print '当前字母 :', i


var = 10
while var > 0:
 var = var -1
 if var == 5:
  continue
 print '当前变量值 :', var

print "Good Bye!"

"""
打印结果如下：
当前字母 : P
当前字母 : y
当前字母 : t
当前字母 : o
当前字母 : n
当前变量值 : 9
当前变量值 : 8
当前变量值 : 7
当前变量值 : 6
当前变量值 : 4
当前变量值 : 3
当前变量值 : 2
当前变量值 : 1
当前变量值 : 0
Good Bye!
"""
