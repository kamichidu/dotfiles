#!/usr/bin/bash

# to avoid `auto/config.cache'
make distclean

./configure \
    --prefix=$HOME/local/ \
    --enable-fail-if-missing \
    --disable-darwin \
    --disable-selinux \
    --with-compiledby=kamichidu \
    --with-x \
    --with-features=huge \
    --enable-luainterp=yes --with-luajit \
    --enable-perlinterp=yes \
    --enable-pythoninterp=yes \
    --enable-rubyinterp=yes \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --enable-gui=gtk2 \
&& make -j5 && make install
