FROM node:6.14-alpine
LABEL MAINTAINER=zhongjiajie955@hotmail.com

RUN apk update \
    && apk upgrade \
    && buildDeps=' \
        tzdata \
    ' \
    && devDeps=' \
        git \
        openssh \
    ' \
    && apk add --no-cache \
       $buildDeps \
       $devDeps \
    # set timezone
    && rm -rf /etc/localtime \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    # clean
    && apk del $buildDeps \
    && rm -rf /var/cache/apk/*