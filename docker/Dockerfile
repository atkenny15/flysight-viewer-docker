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
    cmake \
    vlc-plugin-qt \
    gdb \
    sudo \
    kmod

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Install nvidia driver
COPY nvidia.run /tmp/
RUN cd /tmp && bash nvidia.run --no-kernel-module -s

RUN mkdir -p /usr/local/src/flysight

# Build and install vlc-qt
RUN cd /usr/local/src/flysight && \
    git clone git://github.com/vlc-qt/vlc-qt.git && \
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

# Build flysight viewer
RUN export QT_SELECT=qt5 && \
    cd /usr/local/src/flysight/flysight-viewer-qt/src && \
    qmake && \
    make -j12

# Setup user
ARG user
ARG uid
RUN useradd -G sudo,tty -u ${uid} -m ${user} && \
    echo 'export EDITOR="vim"' >> /home/${user}/.bashrc && \
    echo $user:password | chpasswd
