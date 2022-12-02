# 基础镜像
FROM ubuntu:16.04 as petalinux-requirement
MAINTAINER RESINCS-AT
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV TZ=Asia/Shanghai
# 创建用户petalinux
RUN set -x \
    && adduser --disabled-password --gecos '' petalinux \
    # 创建安装目录
    && mkdir -p /opt/petalinux /home/petalinux /home/petalinux/build \
    && chown -R petalinux:petalinux /opt/petalinux /home/petalinux
# 安装petalinux依赖项
RUN set -x \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt install -y -qq --no-install-recommends \
        tofrodos iproute2 gawk xvfb gcc-4.8 wget build-essential \
        checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev git make \
        net-tools libncurses5-dev zlib1g-dev libssl-dev flex bison \
        libselinux1 gnupg diffstat chrpath socat xterm autoconf libtool \
        tar unzip texinfo gcc-multilib libsdl1.2-dev libglib2.0-dev \
        screen pax gzip language-pack-en libtool-bin cpio lib32z1 lsb-release \
        zlib1g:i386 vim-common libgtk2.0-dev libstdc++6:i386 libc6:i386 \
        expect rsync libtinfo5 curl bc sudo  \
    && apt autoremove --purge  \
    && apt autoclean
# 源码安装jdk17,给Jenkins用
ADD openjdk-17_linux-x64_bin.tar.gz /opt
ENV JAVA_HOME=/opt/jdk-17
ENV PATH=$JAVA_HOME/bin:$PATH
# bash is petalinux recommended shell
RUN ln -fs /bin/bash /bin/sh \
    && echo "petalinux ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


FROM ubuntu-petalinux-requirement:16.04 as petalinux-build
ARG PETALINUX_VERSION=2019.1
LABEL PETALINUX_VERSION=${PETALINUX_VERSION}
# 切换用户
USER petalinux
WORKDIR /home/petalinux/build
# 拷贝petalinux安装包
COPY petalinux-v${PETALINUX_VERSION}-final-installer.run /home/petalinux/build
COPY noninteractive-install.sh /home/petalinux/build
RUN set -x \
    && ./noninteractive-install.sh ${PETALINUX_VERSION} /opt/petalinux \
    && rm -rf petalinux* *log noninteractive-install.sh

ENTRYPOINT ["/bin/bash"]
