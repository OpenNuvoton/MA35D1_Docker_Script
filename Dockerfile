FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install essential Yocto Project host packages
# Clean up the apt cache by removing /var/lib/apt/lists toreduces the image size
# Install repo tool with tinghua mirror: https://mirrors.tuna.tsinghua.edu.cn/git/git-repo
# Origin: http://commondatastorage.googleapis.com/git-repo-downloads/repo
# See: https://mirrors.tuna.tsinghua.edu.cn/help/git-repo/
# Create a non-root user that will perform the actual build
# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN apt-get update && apt-get install -y \
        gawk \
        wget \
        git-core \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        libsdl1.2-dev \
        xterm \
        sed \
        cvs \
        subversion \
        coreutils \
        texi2html \
        docbook-utils \
        python-pysqlite2 \
        help2man \
        make \
        gcc \
        g++ \
        desktop-file-utils \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        mercurial \
        autoconf \
        automake \
        groff \
        curl \
        lzop \
        asciidoc \
        u-boot-tools \
        cpio \
        sudo \
        locales \
        bc \
        libncurses5-dev \
        screen \
        flex \
        bison \
	vim-tiny \
	device-tree-compiler \
	xvfb \
	libgtk2.0-dev \
	libssl-dev \
	net-tools \
	libyaml-dev \
	rsync \
	liblz4-tool \
	zstd \
	python3-pip \
	git-lfs \
	iputils-ping \
	jq \
 && rm -rf /var/lib/apt/lists/* \
 && curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo > /usr/bin/repo \
 && chmod a+x /usr/bin/repo \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && id build1 2>/dev/null || useradd --uid 30000 --create-home build1 \
 && echo "build1 ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8 \
 && pip3 install pyusb usb crypto ecdsa crcmod tqdm pycryptodome pycryptodomex pyelftools

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

USER build1
WORKDIR /home/build1
CMD "/bin/bash"




