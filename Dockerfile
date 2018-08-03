FROM node:9.11-alpine

# android tools
RUN wget -q -O tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip tools.zip
RUN mv "tools" "/opt/android/tools"
RUN rm tools.zip
RUN ln -s "/opt/android/tools/bin/sdkmanager" /usr/bin/sdkmanager

# android build-tools
RUN sdkmanager "build-tools;27.0.3"

# gradle
RUN wget -q -O gradle.zip "https://services.gradle.org/distributions/gradle-4.9-bin.zip"
RUN unzip gradle.zip
RUN mv "gradle-4.9" "/opt/gradle/"
RUN rm gradle.zip
RUN ln -s "/opt/gradle/bin/gradle" /usr/bin/gradle
RUN addgroup -S -g 1100 gradle
RUN adduser -D -S -G gradle -u 1100 -s /bin/ash gradle
RUN mkdir /home/gradle/.gradle
RUN chown -R gradle:gradle /home/gradle

RUN apk add npm
