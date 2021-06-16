FROM ubuntu:20.04
LABEL maintainer="sergey.podobry@gmail.com"
LABEL description="android ndk ci"

RUN apt-get update &&\
    apt-get install -y --no-install-recommends ca-certificates cmake gcc make wget unzip &&\
    rm -rf /var/lib/apt/lists/*

ENV ANDROID_NDK_VERSION r22
ENV ANDROID_NDK_HOME /opt/android-ndk-${ANDROID_NDK_VERSION}

# install NDK
RUN cd /tmp &&\
    wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip &&\
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip 'android-ndk-*/build/cmake/*' 'android-ndk-*/toolchains/*' 'android-ndk-*/NOTICE*' 'android-ndk-*/source.properties' -x '*arm-linux*' '*i686-linux*' '*x86_64-linux*' '*armv7a-linux*' '*x86-4.9*' '*x86_64-4.9*' '*renderscript/*' -d /opt &&\
    rm /tmp/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

WORKDIR /opt
