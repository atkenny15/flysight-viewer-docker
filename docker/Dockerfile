FROM ubuntu:20.04

RUN apt-get update -y

RUN apt-get install -y \
    software-properties-common

RUN apt-get update -y

# Install dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
    libqt5webkit5-dev \
    libqt5webengine5 \
    git \
    build-essential \
    wget \
    libvlc-dev \
    libvlccore-dev \
    libqt5webenginewidgets5 \
    qtwebengine5-dev \
    vlc-plugin-qt \
    gdb \
    sudo \
    kmod \
    python3-pip \
    gcc-10 \
    g++-10 \
    curl \
    gfortran \
    tmux

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# TODO(akenny): Use FindPackage for libflysight
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
    libaec-dev

RUN cd /usr && curl -L https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz | tar --strip 1 -zxv

RUN pip3 install pillow conan

# Install nvidia driver
COPY nvidia.run /tmp/
RUN cd /tmp && bash nvidia.run --no-kernel-module -s

RUN mkdir -p /usr/local/src/flysight

# Build and install vlc-qt
RUN cd /usr/local/src/flysight && \
    git clone https://github.com/vlc-qt/vlc-qt.git && \
    cd vlc-qt && \
    git submodule init && \
    git submodule update

RUN export QT_SELECT=qt5 && \
    cd /usr/local/src/flysight/vlc-qt && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j12 && \
    make install

RUN cp /usr/local/lib/libVLCQtCore.so /usr/local/lib/libvlc-qt.so && \
    cp /usr/local/lib/libVLCQtWidgets.so /usr/local/lib/libvlc-qt-widgets.so

# Build and install wwwidgets-qt
#
# From: http://www.wysota.eu.org/wwwidgets/wwWidgets-1.0-qt5.tar.gz
RUN cd /usr/local/src/flysight && \
    git clone https://github.com/atkenny15/wwwidgets.git

RUN export QT_SELECT=qt5 && \
    cd /usr/local/src/flysight/wwwidgets && \
    qmake && \
    make -j12 sub-widgets

RUN cd /usr/local/src/flysight/wwwidgets && \
    cp widgets/libwwwidgets5.so /usr/lib/libwwwidgets5.so && \
    cp widgets/libwwwidgets5.so /usr/lib/libwwwidgets5.so.1

COPY flysight-viewer-qt /usr/local/src/flysight/flysight-viewer-qt/

## Build flysight viewer
#RUN export QT_SELECT=qt5 && \
#    cd /usr/local/src/flysight/flysight-viewer-qt/src && \
#    conan install -g qmake . && \
#    qmake && \
#    make -j12

# conan create -s compiler.version=10 -s compiler.cppstd=20 -s compiler.libcxx=libstdc++11 .
# conan install -s compiler.version=10 -s compiler.cppstd=20 -s compiler.libcxx=libstdc++11 -g qmake .

# Setup user
ARG user
ARG uid
RUN useradd -s /bin/bash -G sudo,tty -u ${uid} -m ${user} && \
    echo 'export EDITOR="vim"' >> /home/${user}/.bashrc && \
    echo $user:password | chpasswd
