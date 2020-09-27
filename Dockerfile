FROM ubuntu:20.04

ENV TZ=Asia/Shanghai
RUN mkdir /work && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt install -y supervisor wget ca-certificates netbase curl dirmngr apt-transport-https lsb-release && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&\
    apt -y install nodejs gcc g++ make && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  && \
    wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.15.2.linux-amd64.tar.gz && \
    rm -rf go1.15.2.linux-amd64.tar.gz

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
WORKDIR /work
CMD [ "/usr/bin/supervisord" ]