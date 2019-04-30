FROM ubuntu:16.04

RUN apt-get update -y

RUN apt-get install -y \
    software-properties-common

RUN add-apt-repository ppa:ntadej/tano

RUN apt-get update -y

RUN apt-get install -y \
    libqt5webkit5-dev \
    libvlc-qt-dev \
    git \
    build-essential \
    wget

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt-get install -y \
    sudo \
    nvidia-384

RUN cp /usr/lib/libVLCQtCore.so /usr/lib/libvlc-qt.so && \
    cp /usr/lib/libVLCQtWidgets.so /usr/lib/libvlc-qt-widgets.so

RUN mkdir -p /usr/local/src/flysight

# wget http://www.wysota.eu.org/wwwidgets/wwWidgets-1.0-qt5.tar.gz
RUN cd /usr/local/src/flysight && \
    git clone https://github.com/atkenny15/wwwidgets.git

RUN export QT_SELECT=qt5 && \
    cd /usr/local/src/flysight/wwwidgets && \
    qmake && \
    make sub-widgets

RUN cd /usr/local/src/flysight/wwwidgets && \
    cp widgets/libwwwidgets5.so /usr/lib/libwwwidgets5.so && \
    cp widgets/libwwwidgets5.so /usr/lib/libwwwidgets5.so.1

COPY flysight-viewer-qt /usr/local/src/flysight/flysight-viewer-qt/

RUN export QT_SELECT=qt5 && \
    cd /usr/local/src/flysight/flysight-viewer-qt/src && \
    qmake && \
    make

# Setup user
ARG user
ARG uid
RUN useradd -G sudo,tty -u ${uid} -m ${user} && \
    echo 'export EDITOR="vim"' >> /home/${user}/.bashrc && \
    echo $user:password | chpasswd
