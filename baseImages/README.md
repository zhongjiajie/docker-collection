# baseImages

相关的基础镜像

## 镜像说明

* gradle: 主要用于gradle项目的编译.基于gradle:4.9-jdk8-alpine,安装了git,改变了时区
* node: 主要用于nodejs项目的编译.基于node:6.14-alpine,安装了git,改变了时区

## 脚本相关

* build-all.sh: 编译该文件夹下面所有子文件夹的镜像,实质是运行各个子文件夹的`build-*.sh`文件
* ./gradle/build-gradle.sh: 编译gradle文件夹的镜像
* ./node/build-node.sh: 编译node文件夹的镜像
