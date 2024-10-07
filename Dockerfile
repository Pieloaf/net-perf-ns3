# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt-get to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install essential build tools in smaller parts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    libsqlite3-dev \
    libboost-all-dev \
    libssl-dev \
    git \
    python3-setuptools \
    castxml \
    cmake \
    libc6-dev \
    gcc \
    g++ \
    pkg-config \
    sqlite3 \
    qt5-default \
    mercurial \
    ipython3 \
    openmpi-bin \
    openmpi-common \
    openmpi-doc \
    libopenmpi-dev \
    autoconf \
    cvs \
    bzr \
    unrar \
    gdb \
    valgrind \
    uncrustify \
    doxygen \
    graphviz \
    imagemagick \
    python3-sphinx \
    dia \
    tcpdump \
    libxml2 \
    libxml2-dev \
    libclang-6.0-dev \
    llvm-6.0-dev \
    automake \
    python3-pip \
    python3-pygraphviz \
    python3-dev \
    libgsl-dev \
    libgtk-3-dev \
    gnuplot && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install GTK and GObject-related libraries separately to avoid conflicts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gir1.2-goocanvas-2.0 \
    gir1.2-gtk-3.0 \
    libgirepository1.0-dev \
    python3-gi \
    python3-gi-cairo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch to root to install kiwi Python package
RUN pip3 install kiwi

# Download NS-3 all-in-one package
WORKDIR /root
RUN wget -c https://www.nsnam.org/releases/ns-allinone-3.30.1.tar.bz2 && \
    tar -xvjf ns-allinone-3.30.1.tar.bz2 && \
    rm ns-allinone-3.30.1.tar.bz2

# Build NS-3
WORKDIR /root/ns-allinone-3.30.1/ns-3.30.1
RUN ./waf configure && \
    ./waf

# Build NetAnim
WORKDIR /root/ns-allinone-3.30.1/netanim-3.108
RUN qmake NetAnim.pro && \
    make

# Set the default working directory
WORKDIR /root/ns-allinone-3.30.1/ns-3.30.1/scratch/WiFi

