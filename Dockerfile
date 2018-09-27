FROM debian:sid

MAINTAINER HarryChen <shengqi.chen@tuna.tsinghua.edu.cn>

RUN sed -i.bak s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y texlive-full make python3 python3-pip \
    && pip3 install pygments
    && echo "\nmain_memory = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nextra_mem_bot = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nfont_mem_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\npool_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nbuf_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && update-texmf \
    && texhash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*