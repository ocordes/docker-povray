FROM alpine:3.9

# written by: Oliver Cordes 2019-06-25
# changed by: Oliver Cordes 2019-06-25


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

<<<<<<< HEAD
COPY create_povray.sh .
RUN chmod 755 create_povray.sh
RUN ./create_povray.sh
=======
RUN ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
      CXXFLAGS="-O3 -march=sandybridge -include uint-hack.h -I/usr/include/OpenEXR"
RUN make install && mv /usr/local/bin/povray /usr/local/bin/povray.sandybridge
RUN make clean
RUN ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
      CXXFLAGS="-O3 -march=nehalem -include uint-hack.h -I/usr/include/OpenEX$"
RUN make install && mv /usr/local/bin/povray /usr/local/bin/povray.nehalem
RUN make clean
RUN ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
      CXXFLAGS="-O3 -march=core2 -include uint-hack.h -I/usr/include/OpenEXR"
RUN make install && mv /usr/local/bin/povray /usr/local/bin/povray.core2
RUN make clean
RUN ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
      CXXFLAGS="-O3 -march=k8 -include uint-hack.h -I/usr/include/OpenEXR"
RUN make install && mv /usr/local/bin/povray /usr/local/bin/povray.k8
RUN make clean
RUN ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
      CXXFLAGS="-O3 -march=x86-64 -include uint-hack.h -I/usr/include/OpenEXR"
RUN make install && mv /usr/local/bin/povray /usr/local/bin/povray.x86-64
>>>>>>> ae3f56fb587ed31103474238c74276cc98409dd8

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


