FROM ubuntu:20.10 as builder

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC
ARG WWWGROUP

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget clang cmake ninja-build pkg-config libgtk-3-dev \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN useradd -ms /bin/bash user

RUN groupadd --force -g 1000 user
RUN useradd -ms /bin/bash --no-user-group -g 1000 -u 1337 user

USER user
WORKDIR /home/user

#Installing Android SDK
RUN mkdir -p Android/sdk
RUN mkdir -p /home/user/app

ENV ANDROID_SDK_ROOT /home/user/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager --install "cmdline-tools;latest"
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/user/Android/sdk/platform-tools"

#Installing Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/user/flutter/bin"
RUN flutter channel dev
RUN flutter upgrade
RUN flutter doctor

RUN flutter config --enable-web
RUN flutter config --enable-android
RUN yes | flutter doctor --android-licenses

COPY . /home/user/app
COPY ./pubspec.yaml /home/user/app/pubspec.yaml
WORKDIR /home/user/app
RUN chown -R user:user /home/user/app
#RUN   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

RUN flutter pub upgrade
RUN flutter pub get --no-sound-null-safety
RUN flutter build apk --split-per-abi --no-sound-null-safety