# docker-repo

开发过程中比较有用的docker镜像,以docker-compose的方式编排,方便搭建测试和开发环境.

## 仓库解释

* baseImages: 自定义的基础镜像仓库
* elasticsearch: elasticsearch单实例部署
* ftp: ftp服务器
* mysql: mysql单实例服务器
* redis: redis单实例服务器
* registry: docker registry

## 脚本解释

* maintain.sh: docker-compose维护脚本.
  * 删除docker中的dangling镜像`./maintain.sh i|image`
  * 删除docker中已经退出的容器`./maintain.sh c|container`
* repo.sh: 启动 停止 重启 docker-compose项目.
  * 启动: `./repo.sh start -v venv -f /path/to/docker-compose`
  * 停止: `./repo.sh stop -v venv -f /path/to/docker-compose`
  * 重启: `./repo.sh restart -v venv -f /path/to/docker-compose`

## 更新公网镜像

部分仓库基于公网,当公网的仓库更新时应该随着内网也应该定时更新,目前没有想到很好的更新方式,只能手动更新(基础组件镜像不会有太大的改动,所以不会有大的冲突),下面以[github-docker-gitlab][2]为例说明手动更新

```shell
cd /path/to/update
git clone git@github.com:sameersbn/docker-gitlab.git
# 删除 /path/to/update/docker-gitlab 项目除了 .git 文件夹之外的内容
# 手动将该项目的docker-gitlab文件夹的全部内容复制到 /path/to/update/docker-gitlab 中
git status  # 查看该项目和公网的项目有没有区别
git diff    # 如果有区别查看两个项目的区别,并人工选择要更新的内容完成更新
# 将人工更新完的内容复制回该项目的docker-gitlab文件夹中
```

### 部分仓库更新说明

* redis-cluster: 在[github-redis-cluster][3]的基础上更新了redis镜像版本

## 批量修改volumns的shell脚本

repo的volumn路径都是`/path/to`,使用的时候要修改成对应自己的路径名,这里提供一个简易方法用来实现这个功能

```sh
DOCKERDATA_PATH="/PUT/YOUR/LOCAL/PATH/HERE"
DOCKERDATA_PATH_REPLACE="${DOCKERDATA_PATH//\//\\/}"
find . -name '*.yml' | while read file_path; do
    sed -i '' "s/\/path\/to\/DockerData/$DOCKERDATA_PATH_REPLACE/g" $file_path
done
```

## TODO

## 其他实用的docker-repo

* [docker-airflow](https://github.com/puckel/docker-airflow)
