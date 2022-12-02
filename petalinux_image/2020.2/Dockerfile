# 基础镜像
FROM ubuntu:18.04 as petalinux-requirement
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
    && apt install -y  zlib1g-dev zlib1g:i386  xterm autoconf libtool texinfo  \
    gcc-multilib libncurses-dev libtinfo5 openjdk-17-jdk git curl rsync gawk  \
    build-essential bc net-tools sudo python3 \
    && apt autoremove --purge  \
    && apt autoclean
# bash is petalinux recommended shell
RUN ln -fs /bin/bash /bin/sh \
    && echo "petalinux ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


FROM ubuntu-petalinux-requirement:18.04 as petalinux-build
ARG PETALINUX_VERSION=2020.2
LABEL PETALINUX_VERSION=${PETALINUX_VERSION}
# 切换用户
USER petalinux
WORKDIR /home/petalinux/build
# 拷贝petalinux安装包
COPY petalinux-v${PETALINUX_VERSION}-final-installer.run /home/petalinux/build
RUN set -x \
    && SKIP_LICENSE=y /home/petalinux/build/petalinux-v${PETALINUX_VERSION}-final-installer.run -d /opt/petalinux --platform "arm" \
    && rm -rf petalinux* *log

ENTRYPOINT ["/bin/bash"]
