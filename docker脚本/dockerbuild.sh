#!/bin/bash
#切换到项目目录
cd /root/opcredis

#查看jdk环境配置

java -version
if [ $? -eq 0 ]; then
    echo "JDK环境已配置..."
    
  else
    echo "请查看JDK环境是否配置正确..."    
fi

sleep 3

#查看docker服务状态
if [[ $(docker --version) && $(systemctl status docker) ]]; then
    echo "Docker 服务已启动..."
    
  else
    echo "请查看Docker服务是否安装或者未启动"    
fi

sleep 3

#查看maven环境
if [[ $(mvn -v) ]]; then
    echo "mvn环境已配置..."
    
  else
    echo "请查看mvn环境是否配置正确..."
fi

sleep 3
#执行mvn打包
echo "执行mvn打包..."
sleep 2
mvn clean install
if [ $? -eq 0 ]; then
    echo "mvn打包成功"
    sleep 3
  else
    echo "执行mvn打包失败"
    exit 1
fi


#执行docker镜像构建
echo "执行docker镜像构建"
sleep 2
docker build -t dataconnect:0.0.1 -f Dockerfile .

if [ $? -eq 0 ]; then
    echo "执行docker镜像打包成功！"
    sleep 3
  else
    echo "执行docker镜像打包失败，请查看原因..."
    exit 1
fi

#启动项目docker容器
echo "启动项目docker容器"
sleep 2
docker run -d -it -p 9031:9031 dataconnect:0.0.1

if [ $? -eq 0 ]; then
    echo "docker容器启动成功！"
    echo "项目访问端口为：9031"
    sleep 2
  else
    echo "docker启动失败，请查看原因..."
    exit 1
fi

