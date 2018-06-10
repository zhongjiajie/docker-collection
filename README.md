# docker-rocketmq

[docker-rocketmq][1] is basic [apache rockermq][2] docker container which base on [rocketmq-externals-docker][3] and make some changes make it more convenient.

## Feature

* One image: make only one image to declare rocketmq-namesrv and rocketmq-broker, which difference from [rocketmq-externals-docker][3] make two images
* Custom JVM MEMORY: docker-compose has environment variables named `JVM_MEMORY` convenient to set runtime JVM memory
* Scale service easier: use docker-compose can scale service easier

## Informations

* Based on Java-8 official Image [java:8][4]
* Install [Docker][5]
* Install [Docker Compose][6]
* Following the rocketmq release from [dist.apache.org][7]

## Installation

* **Pull** the image from the Docker repository

  ```shell
  docker pull zhongjiajie/docker-rocketmq
  ```

* **Build** by yourself(it is helpful if you want to make some change base on this repo)

  ```shell
  git clone https://github.com/zhongjiajie/docker-rocketmq
  cd docker-rocketmq
  docker build --rm -t zhongjiajie/rocketmq .
  ```

## Usage

By default, you can run rocketmq with simple command

```shell
docker-compose up -d
```

This command will run exactly one rocketmq-namesrv and one rocketmq-broker with given `JVM_MEMORY` environment define in **docker-compose.yml**. if you want to run in custom `JVM_MEMORY` environment you can change the variable in **docker-compose.yml** and start by the same command `docker-compose up -d`

To stop the runing container

```shell
docker-compose down
```

Scale the number of broker, if you want to start rocketmq with numbers of broker, you could run docker-compose with `--scale` flag

```shell
# eg if you want to scale 3 mqbrokers
docker-compose up --scale mqbroker=3 --no-recreate
```

## Wanna help?

Fork, improve and PR. ;-)

[1]: https://github.com/zhongjiajie/docker-rocketmq
[2]: https://github.com/apache/rocketmq
[3]: https://github.com/apache/rocketmq-externals/tree/master/rocketmq-docker
[4]: https://hub.docker.com/_/java/
[5]: https://www.docker.com/
[6]: https://docs.docker.com/compose/install/
[7]: https://dist.apache.org/repos/dist/release/rocketmq/