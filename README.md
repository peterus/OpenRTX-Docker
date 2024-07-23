# OpenRTX-Docker

With this repository you can have a build system for [OpenRTX](https://github.com/OpenRTX/OpenRTX) in a docker image.
It will help to install all dependencies and minimize your setup time. With this image there is no `works on my machine` :)

## Use the official image

First you need to clone the official OpenRTX repository. Next you need to start the container with this OpenRTX-Docker image.

    git clone https://github.com/OpenRTX/OpenRTX.git
    cd OpenRTX
    docker run --rm -it -v $PWD:/OpenRTX ghcr.io/peterus/openrtx-docker:main bash

Inside of the container you can jump into the directory and start compiling the project.

    cd /OpenRTX
    meson setup --cross-file cross_arm.txt build_arm
    meson compile -C build_arm openrtx_mduv3x0_wrap

You will find all the compiled binaries etc. in build_arm like if you would compile it native on your computer.

## Build the image from source

    docker build . -t openrtx

now you can use our image like this

    docker run --rm -it -v $PWD:/OpenRTX openrtx bash

But be careful this process will take some time as a lot of dependencies are getting installed and compiled. It is recommended to use the pre-build docker image.
