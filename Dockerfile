FROM debian:latest
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        git \
        liblua5.1-dev \
        luajit \
        libluajit-5.1 \
        python2-dev # might need to be python2.7-dev \
        python3.7-dev \
        ruby-dev \
        libperl-dev \
        libncurses5-dev \
        libatk1.0-dev \
        libx11-dev \
        libxpm-dev \
        libxt-dev \
    && rm -rf \
        /usr/local/share/vim \
        /usr/bin/vim
RUN git clone https://github.com/vim/vim ~/vimtemp
RUN cd ~/vimtemp && ./configure \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --with-ruby-command=/usr/bin/ruby \
    --enable-pythoninterp=dynamic \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu \
    --enable-luainterp \
    --with-luajit \
    --enable-cscope \
    --enable-gui=auto \
    --with-features=huge \
    --with-x \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --with-compiledby="adamsanghera" \
    --enable-fail-if-missing
RUN cd ~/vimtemp && make && make install
RUN cd ~/ \
    && git clone https://github.com/adamsanghera/.vim.git \
    && cd ~/.vim \
    && git checkout v1.4
RUN apt-get install -y python3-pip \
    && python3 -m pip install pynvim
RUN cd ~/.vim && ./setup.sh
RUN vim +PlugInstall +qall
CMD /bin/bash
