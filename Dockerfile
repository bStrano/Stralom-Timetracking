# Install Operating system and dependencies
FROM ubuntu as build

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 snapd
RUN apt-get clean


# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"


# Run flutter doctor
RUN flutter doctor

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web



# Copy files to container and build
WORKDIR /app/

COPY . /app/


RUN flutter pub get
RUN flutter clean
RUN flutter build web

FROM nginx:stable-alpine as core

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g", "daemon off;"]
