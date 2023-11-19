FROM nvidia/cuda:11.6.2-base-ubuntu20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    clang \
    git \
    libgdm-dev \
    libncurses5-dev \
    libpcap-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtk8.6 \
    llvm-dev \
    wget \
    xz-utils \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

ARG PYTHON_VERSION=3.8.18
ENV PYTHON_SRC_DIR="/src/python${PYTHON_VERSION}"
RUN wget -q "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz" && \
    mkdir -p "${PYTHON_SRC_DIR}" && \
    tar xf "Python-${PYTHON_VERSION}.tar.xz" -C "${PYTHON_SRC_DIR}" --strip-components=1 && \
    rm "Python-${PYTHON_VERSION}.tar.xz" && \
    cd "${PYTHON_SRC_DIR}" && \
    CC=clang ./configure --enable-optimizations --with-lto --prefix="/usr" && \
    make -j "$(nproc)" && \
    make install && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    rm -rf "${PYTHON_SRC_DIR}"

ENV TZ=Europe/Berlin
ENV PYTHONPATH=/src/2023-challenge
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY . /src/2023-challenge/
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir /src/2023-challenge

CMD ["python3", "-O", "/src/2023-challenge/run.py"]
