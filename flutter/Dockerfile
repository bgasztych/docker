FROM --platform=linux/amd64 ubuntu:jammy

USER root

ARG flutter_version=3.32.8

ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV FLUTTER_HOME=${HOME}/sdks/flutter
ENV FLUTTER_ROOT=$FLUTTER_HOME
ENV FLUTTER_VERSION=$flutter_version
ENV FIREBASE_INSTALL_DIR=/usr/local/bin

ENV PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin

# comes from https://developer.android.com/studio/
ENV ANDROID_SDK_TOOLS_VERSION=13114758


# comes from https://github.com/firebase/firebase-tools/releases
ENV FIREBASE_VERSION=v14.12.0

RUN cd /opt \
    && apt update \
    && apt install -y openjdk-21-jdk \
    && apt install ca-certificates-java \
    && apt install -y sudo wget zip unzip git openssh-client curl software-properties-common build-essential ruby-full ruby-bundler lib32stdc++6 libstdc++6 libpulse0 libglu1-mesa locales lcov --no-install-recommends \
    # for x86 emulators
    && apt install -y libxtst6 libnss3-dev libnspr4 libxss1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libgdk-pixbuf2.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && sudo sh -c 'echo "en_US.UTF-8 UTF-8" > /etc/locale.gen' \
    && sudo locale-gen \
    && sudo update-locale LANG=en_US.UTF-8 \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
    && rm android-sdk-tools.zip \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/tools \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && yes | sdkmanager --licenses \
    && wget -O /usr/bin/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/master/community-cookbooks/android-sdk/files/default/android-wait-for-emulator \
    && chmod +x /usr/bin/android-wait-for-emulator \
    && touch /root/.android/repositories.cfg \
    && sdkmanager tools \
    && sdkmanager platform-tools \
    && sdkmanager emulator

RUN sudo mkdir -p "$FIREBASE_INSTALL_DIR" \
    && sudo curl -o "$FIREBASE_INSTALL_DIR/firebase" -L --progress-bar https://firebase.tools/bin/linux/${FIREBASE_VERSION} \
    && sudo chmod +rx "$FIREBASE_INSTALL_DIR/firebase"

# Install Flutter
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

RUN flutter doctor
