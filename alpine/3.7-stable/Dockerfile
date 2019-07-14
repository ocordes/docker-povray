FROM alpine:3.9

# written by: Oliver Cordes 2019-06-23
# changed by: Oliver Cordes 2019-06-23


RUN apk add --update --no-cache \
    git \
    coreutils \
    build-base \
    autoconf \
    automake \
    bash \
    boost-dev \
    zlib-dev \
    libpng-dev \
    tiff-dev \
    sdl-dev \
    ilmbase-dev \
    openexr-dev \
    cmake 

RUN git clone https://github.com/ocordes/detect-cpu.git && \
    cd /detect-cpu  && \
    mkdir build && cd build && \
    cmake .. && make


RUN git clone https://github.com/POV-Ray/povray.git && \
    cd /povray && \
    git checkout 3.7-stable && \
    cd /povray/unix && \
    ./prebuild.sh && \
    cd /povray &&  \
    echo "typedef unsigned int uint;" > uint-hack.h 

WORKDIR /povray

COPY create_povray.sh .
RUN chmod 755 create_povray.sh
RUN ./create_povray.sh

WORKDIR /

RUN cd / && \
    rm -rf /povray && \
    rm -rf /usr/local/share/doc/povray-3.7 && \
    rm -rf /usr/local/share/povray-3.7/scenes


FROM alpine:3.9

COPY --from=0 /detect-cpu/build/detect-cpu /usr/local
COPY --from=0 /usr/local /usr/local
COPY --from=0 /root/.povray /root/.povray

RUN apk add --update --no-cache \
    boost \
    zlib \
    libpng \
    tiff \
    sdl \
    ilmbase \
    openexr && \
    rm -rf /var/cache/apk*

RUN mkdir /source && \
    mkdir /output


WORKDIR /source

COPY povray /usr/local/bin/povray
RUN chmod 755 /usr/local/bin/povray

ENTRYPOINT ["/usr/local/bin/povray"]


