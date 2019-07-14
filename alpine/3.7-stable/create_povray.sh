#!/bin/sh

for arch in core2 nehalem westmere sandybridge ivybridge haswell broadwell skylake knl knm silvermont bonell athlon64 athlon64-sse3 amdfam10 btver1 btver2 bdver1 bdver2 znver1 x86-64 ; do
 ./configure COMPILED_BY="Oliver Cordes ocordes/povray:3.7-stable" \
      --disable-optimiz \
 CXXFLAGS="-O3 -march=${arch} -include uint-hack.h -I/usr/include/OpenEXR"
 make install && mv /usr/local/bin/povray /usr/local/bin/povray.${arch}
 make clean
done
