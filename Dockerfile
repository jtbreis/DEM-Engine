FROM --platform=linux/amd64 nvidia/cuda:12.0.1-devel-ubuntu22.04 AS base-amd64-gpu

RUN apt-get update && apt-get install -y build-essential ninja-build cmake git

COPY . /DEM-Engine
WORKDIR /DEM-Engine

RUN git submodule init && git submodule update

ENV CPATH=/usr/local/cuda-12.0/targets/x86_64-linux/include${CPATH:+:${CPATH}}
ENV PATH=/usr/local/cuda-12.0/bin${PATH:+:${PATH}}
ENV PATH=/usr/local/cuda-12.0/lib64/cmake${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
ENV CUDA_HOME=/usr/local/cuda-12.0

RUN mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j 4

ENTRYPOINT [ "/bin/bash" ]