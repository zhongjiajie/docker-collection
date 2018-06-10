# DESCRIPTION: Basic apache rockermq docker container
# BUILD: docker build --rm -t zhongjiajie/rocketmq:4.1.0 .
# SOURCE: https://github.com/zhongjiajie/docker-rocketmq

FROM java:8
LABEL MAINTAINER=zhongjiajie955@hotmail.com

# set rocketmq version, search version in `https://dist.apache.org/repos/dist/release/rocketmq/` if you want to change or upgrade rockermq version
ARG version=4.1.0-incubating

# Rocketmq version
ENV ROCKETMQ_VERSION ${version}

# Rocketmq home
ENV ROCKETMQ_HOME /opt/rocketmq-${ROCKETMQ_VERSION}

WORKDIR ${ROCKETMQ_HOME}

COPY script/entrypoint.sh /entrypoint.sh

RUN curl https://dist.apache.org/repos/dist/release/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o rocketmq.zip \
    && unzip rocketmq.zip \
    && mv rocketmq-all*/* . \
    && rmdir rocketmq-all*  \
    && rm rocketmq.zip \
    # make dir for rocketmq's logs & store
    && mkdir -p /opt/logs /opt/store \
    && chmod +x /entrypoint.sh

# DEBUG mode can download `rocketmq-release.zip` file to reduce curl time
# COPY rocketmq-all-4.1.0-incubating-bin-release.zip rocketmq.zip
# RUN unzip rocketmq.zip \
#     && mv rocketmq-all*/* . \
#     && rmdir rocketmq-all*  \
#     && rm rocketmq.zip \
#     # make dir for rocketmq's logs & store
#     && mkdir -p /opt/logs /opt/store \
#     && chmod +x /entrypoint.sh

EXPOSE 9876 10909 10911
VOLUME /opt/logs \
       /opt/store

ENTRYPOINT ["/entrypoint.sh"]