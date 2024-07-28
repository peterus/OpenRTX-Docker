FROM ubuntu:24.04 AS build

# dependencies for miosix compiler
RUN apt-get update -y && apt-get install -y \
  git \
  wget \
  sudo \
  build-essential \
  libncurses5-dev \
  byacc \
  flex \
  texinfo \
  patch \
  tar \
  unzip \
  lzip \
  libelf-dev \
  perl \
  libexpat1-dev \
  && rm -rf /var/lib/apt/lists/*

# compile miosix compiler
COPY install-script.sh .
RUN git clone --depth 1 https://github.com/fedetft/miosix-kernel.git \
  && mv install-script.sh miosix-kernel/miosix/_tools/compiler/gcc-9.2.0-mp3.1/install-script.sh \
  && cd miosix-kernel/miosix/_tools/compiler/gcc-9.2.0-mp3.1 \
  && sh download.sh \
  && bash install-script.sh -j`nproc` \
  && bash cleanup.sh \
  && cd \
  && rm -rf miosix-kernel

# dependencies for the project
RUN apt-get update -y && apt-get install -y \
  git \
  pkg-config \
  build-essential \
  meson \
  libsdl2-dev \
  libreadline-dev \
  dfu-util \
  cmake \
  libusb-1.0-0 \
  libusb-1.0-0-dev \
  codec2 \
  libcodec2-dev \
  && rm -rf /var/lib/apt/lists/*

# install OpenGD77
RUN git clone --depth 1 https://github.com/open-ham/OpenGD77.git /tmp/OpenGD77

# fix error from git with different users
RUN git config --system --add safe.directory '*'
