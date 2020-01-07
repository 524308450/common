#!/usr/bin/python
# -*- coding: UTF-8 -*-

###continue 语句跳出本次循环，而break跳出整个循环####
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

n = 0
while n < 10:
    n = n + 1
#    if n % 2 == 0:      # 如果n是偶数，执行continue语句
    if  n%2:      # 如果n是奇数，执行continue语句
        continue        # continue语句会直接继续下一轮循环，后续的print()语句不会执行
    print(n)

"""
2
4
6
8
10
"""



var = 10

while var > 0:
    var = var -1
    if var == 5 or var == 8:
        continue
    print '当前值 :', var
print "Good bye!"

"""
当前值 : 9
当前值 : 7
当前值 : 6
当前值 : 4
当前值 : 3
当前值 : 2
当前值 : 1
当前值 : 0
Good bye!
"""

#打印8行5列的星星
j = 0  # 定义初始化j表示行数
while j < 8:    #定义循环8次，生成打印1行10列的星星
    i = 0 # 定义初始化i表示列数
    while i < 5:
        print('★', end='')   # 打印1行5个星星
        i += 1
    print('\n', end='')   # 为当前行结束添加一个换行符号
    j += 1   #j自增操作


#打印8行5列隔行变色的星星
j = 1  # 定义初始化j表示行数
while j <= 8:    #定义循环8次，生成打印1行10列的星星
    i = 0 # 定义初始化i表示列数
    while i < 5:
        if j % 2 == 0: # 判断是奇数行还是偶数行，偶数打印
            print('★', end='')
        else:
            print('☆', end='')   # 判断是奇数行还是偶数行，奇数打印
        i += 1
    print('\n', end='')   # 为当前行结束添加一个换行符号
    j += 1   #j自增操作

#打印8行5列隔列变色的星星
j = 1  # 定义初始化j表示行数
while j <= 8:    #定义循环8次，生成打印1行10列的星星
    i = 1 # 定义初始化i表示列数
    while i <= 5:
        if i % 2 == 0: # 判断是奇数行还是偶数行，偶数打印
            print('★', end='')
        else:
            print('☆', end='')   # 判断是奇数行还是偶数行，奇数打印
        i += 1
    print('\n', end='')   # 为当前行结束添加一个换行符号
    j += 1   #j自增操作


##打印三角形
i = 1
while i <= 5:
    j = 1
    while j <= i:
        print('★', end='')
        j += 1
    print('\n', end='')
    i += 1

#印九九乘法表 
i = 1
while i <= 9:
    j = 1
    while j <= i:
        result = j * i
        print(i,'×',j,'=',result,end='\t')  #print('%2d*%2d = %2d'%(j,i,result),' ',end = '')
        j += 1
    print()
    i += 1

##石头剪刀布
#1 提示并获取用户的输入
player = int(input("请输入 0剪刀 1石头 2布："))
#2 设定电脑的输入，默认为1 石头
computer = 1
#3 判断用户的输入，然后显示对应的结果
if(player==0 and computer==2) or (player==1 and computer==0) or (player==2 and computer==1):
    print("赢了，可以去买奶粉了")
elif(player==computer):
    print("平局了，洗洗手决战到天亮")
else:
    print("输了，回家跪搓衣板")


##剪刀石头
import random
#1 提示并获取用户的输入
player = int(input("请输入 0剪刀 1石头 2布："))
#2 设定电脑的输入，导入函数random，采用randin（0,2）表示随机生成数字0 ~ 2
computer = random.randint(0,2)
print("电脑随机出数",computer)
#3 判断用户的输入，然后显示对应的结果
if(player==0 and computer==2) or (player==1 and computer==0) or (player==2 and computer==1):
    print("赢了，可以去买奶粉了")
elif(player==computer):
    print("平局了，洗洗手决战到天亮")

# 打印 1—100之间的偶数
# 首先创建一个1—100的集合，利用range函数，生成的半开半闭的区间，所以最后得+1。
num = range(1, 101)
for n in num:
    if n % 2 == 0:
        print(n,)
else:
    print("以上数字为1-100之内的偶数")


##遍历字典
d = {'x':1,'y':32,'z':10} # 定义字典d，里面有3个元素
for key in d:  #遍历字典
    print(key)
