FROM openjdk:8-alpine3.8

ENV ANDROID_SDK_HOME /opt/android
ENV ANDROID_SDK_ROOT /opt/android
ENV ANDROID_HOME /opt/android
ENV ANDROID_SDK /opt/android

# android tools
RUN wget -q -O tools.zip http://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip tools.zip
RUN mkdir /opt
RUN mkdir /opt/android
RUN mv "tools" "/opt/android/tools"
RUN rm tools.zip
ENV PATH "${PATH}:/opt/android/tools/bin"

RUN env

# android build-tools
RUN yes | sdkmanager --licenses
RUN sdkmanager "build-tools;27.0.3"
ENV PATH "${PATH}:/opt/android/build-tools/27.0.3"

# gradle
RUN wget -q -O gradle.zip "https://services.gradle.org/distributions/gradle-4.9-bin.zip"
RUN unzip gradle.zip
RUN mv "gradle-4.9" "/opt/gradle/"
RUN rm gradle.zip
RUN ln -s "/opt/gradle/bin/gradle" /usr/bin/gradle
RUN addgroup -S -g 1100 gradle
RUN adduser -D -S -G gradle -u 1100 -s /bin/ash gradle
RUN mkdir /home/gradle/.gradle
RUN export GRADLE_USER_HOME=/home/gradle/.gradle
RUN chown -R gradle:gradle /home/gradle
ENV PATH "${PATH}:/opt/gradle/bin"

RUN apk --update add npm
RUN apk add bash
