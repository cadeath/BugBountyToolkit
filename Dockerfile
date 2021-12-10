FROM ubuntu:18.04

LABEL maintainer="Eskie Maquilang"
LABEL version="1.7"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive

ENV AQUATONE_VERSION=1.7.0


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir ${HOME}/wordlists

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    vim \
    wget \
    tzdata \
    curl \
    make \
    nmap \
    whois \
    python \
    python-pip \
    python3 \
    python3-pip \
    perl \
    nikto \
    dnsutils \
    net-tools \
    unzip\
    exif\
    zsh\
    nano\
    && rm -rf /var/lib/apt/lists/*

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    sqlmap \
    # dirb
    dirb \
    # dnsenum
    cpanminus \
    # wfuzz
    python-pycurl \
    python3-dev \
    # knock
    python-dnspython \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    # masscan
    libpcap-dev \
    # theharvester
    python3.7 \
    # joomscan
    libwww-perl \
    # hydra
    hydra \
    # dnsrecon
    dnsrecon \
    # zsh
    powerline\
    # zsh
    fonts-powerline\
    htop \
    && rm -rf /var/lib/apt/lists/*


# awscli
RUN pip3 install awscli==1.22.14


# nmap scripts
RUN wget -O /usr/share/nmap/scripts/vulners.nse https://svn.nmap.org/nmap/scripts/vulners.nse
RUN wget -O /usr/share/nmap/scripts/http-wordpress-info.nse https://raw.githubusercontent.com/hackertarget/nmap-nse-scripts/master/http-wordpress-info.nse


# tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata


# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools && python3.7 -m pip install --upgrade setuptools


# dnsenum
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/fwaeytens/dnsenum.git && \
    cd dnsenum/ && \
    chmod +x dnsenum.pl && \
    ln -s ${HOME}/toolkit/dnsenum/dnsenum.pl /usr/bin/dnsenum && \
    cpanm String::Random && \
    cpanm Net::IP && \
    cpanm Net::DNS && \
    cpanm Net::Netmask && \
    cpanm XML::Writer


# Sublist3r
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    pip install -r requirements.txt && \
    ln -s ${HOME}/toolkit/Sublist3r/sublist3r.py /usr/local/bin/sublist3r


# wfuzz
RUN python3 -m pip install wfuzz


# knock
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/guelfoweb/knock.git && \
    cd knock && \
    chmod +x setup.py && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install python3.7 -y && \
    python3.7 setup.py install


# massdns
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf ${HOME}/toolkit/massdns/bin/massdns /usr/local/bin/massdns


# wafw00f
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/enablesecurity/wafw00f.git && \
    cd wafw00f && \
    chmod +x setup.py && \
    python setup.py install


# wpscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan


# commix 
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/commixproject/commix.git && \
    cd commix && \
    chmod +x commix.py && \
    ln -sf ${HOME}/toolkit/commix/commix.py /usr/local/bin/commix


# masscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/toolkit/masscan/bin/masscan /usr/local/bin/masscan    


# altdns
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/infosec-au/altdns.git && \
    cd altdns && \
    pip install -r requirements.txt && \
    chmod +x setup.py && \
    python setup.py install


# teh_s3_bucketeers
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/tomdev/teh_s3_bucketeers.git && \
    cd teh_s3_bucketeers && \
    chmod +x bucketeer.sh && \
    ln -sf ${HOME}/toolkit/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer


# Recon-ng
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    pip3 install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf ${HOME}/toolkit/recon-ng/recon-ng /usr/local/bin/recon-ng


# XSStrike
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/toolkit/XSStrike/xsstrike.py /usr/local/bin/xsstrike


# theHarvester
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/theHarvester.git && \
    cd theHarvester && \
    python3 -m pip install -r requirements.txt && \
    chmod +x theHarvester.py && \
    ln -sf ${HOME}/toolkit/theHarvester/theHarvester.py /usr/local/bin/theharvester


# CloudFlair
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/christophetd/CloudFlair.git && \
#     cd CloudFlair && \
#     pip install -r requirements.txt && \
#     chmod +x cloudflair.py && \
#     ln -sf ${HOME}/toolkit/CloudFlair/cloudflair.py /usr/local/bin/cloudflair


# LinkFinder
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/GerbenJavado/LinkFinder.git && \
    cd LinkFinder && \
    python3 setup.py install && \
    pip3 install -r requirements.txt && \
    chmod +x linkfinder.py
    # ln -sf ${HOME}/toolkit/LinkFinder/linkfinder.py /usr/local/bin/linkfinder


# joomscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/rezasp/joomscan.git && \
    cd joomscan/ && \
    chmod +x joomscan.pl
COPY joomscan.sh /opt
RUN chmod +x /opt/joomscan.sh && \
    ln -sf /opt/joomscan.sh /usr/local/bin/joomscan


# go1.17
RUN cd /opt && \
    wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz && \
    tar -xvf go1.17.3.linux-amd64.tar.gz && \
    rm -rf /opt/go1.17.3.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}


# gobuster
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/OJ/gobuster.git && \
    cd gobuster && \
    go get && go install


# virtual-host-discovery
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/virtual-host-discovery.git && \
    cd virtual-host-discovery && \
    chmod +x scan.rb && \
    ln -sf ${HOME}/toolkit/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery


# bucket_finder
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/bucket_finder.git && \
    cd bucket_finder && \
    chmod +x bucket_finder.rb && \
    ln -sf ${HOME}/toolkit/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder


# dirsearch
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/dirsearch.git && \
    cd dirsearch && \
    chmod +x dirsearch.py && \
    ln -sf ${HOME}/toolkit/dirsearch/dirsearch.py /usr/local/bin/dirsearch


# s3recon
RUN pip3 install --upgrade setuptools && \
    pip3 install pyyaml pymongo requests s3recon


# subfinder
RUN GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder


# zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh &&\
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc &&\
    chsh -s /bin/zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


# dotdotpwn
RUN cd ${HOME}/toolkit && \
    cpanm Net::FTP && \
    cpanm Time::HiRes && \
    cpanm HTTP::Lite && \
    cpanm Switch && \
    cpanm Socket && \
    cpanm IO::Socket && \
    cpanm Getopt::Std && \
    cpanm TFTP && \
    git clone https://github.com/AlexisAhmed/dotdotpwn.git && \
    cd dotdotpwn && \
    chmod +x dotdotpwn.pl && \
    ln -sf ${HOME}/toolkit/dotdotpwn/dotdotpwn.pl /usr/local/bin/dotdotpwn


# whatweb
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/urbanadventurer/WhatWeb.git && \
    cd WhatWeb && \
    chmod +x whatweb && \
    ln -sf ${HOME}/toolkit/WhatWeb/whatweb /usr/local/bin/whatweb


# fierce
RUN python3 -m pip install fierce


# amass
RUN export GO111MODULE=on && \
    go get -v github.com/OWASP/Amass/v3/...


# S3Scanner
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/sa7mon/S3Scanner.git && \
    cd S3Scanner && \
    pip3 install -r requirements.txt


# droopsecan
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/droope/droopescan.git && \
#     cd droopescan && \
#     pip install -r requirements.txt


# subjack
RUN go get github.com/haccer/subjack


# SubOver
RUN go get github.com/Ice3man543/SubOver


# ZSH configuration
RUN export SHELL=/usr/bin/zsh && \
    cd ${HOME} && \
    rm .zshrc && \
    wget https://raw.githubusercontent.com/AlexisAhmed/BugBountyToolkit-ZSH/main/.zshrc


# ffuf
RUN go get -u github.com/ffuf/ffuf


# httprobe
RUN go get -u github.com/tomnomnom/httprobe


# gitGraber
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/hisxo/gitGraber.git && \
    cd gitGraber && \
    ln -sf ${HOME}/toolkit/gitGraber/gitGraber.py /usr/local/bin/gitGraber


# waybackurls
RUN go get github.com/tomnomnom/waybackurls

# Katoolin
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/LionSec/katoolin.git && \
    cd katoolin && \
    chmod +x katoolin.py

# Nuclei
RUN export GO111MODULE=on && \
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# Interactsh
RUN export GO111MODULE=on && \
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# Chromium
WORKDIR /opt/chromium
RUN apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils libgbm-dev

RUN git clone https://github.com/scheib/chromium-latest-linux
RUN cd /opt/chromium/chromium-latest-linux && \
    ./update.sh && ln -s /opt/chromium/chromium-latest-linux/latest/chrome /usr/bin/chromium

WORKDIR ${HOME}

# aquatone
RUN cd ${HOME}/toolkit && \
    wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && \
    unzip aquatone_linux_amd64_1.7.0.zip -d aquatone && rm aquatone_linux_amd64_1.7.0.zip && \
    cp ./aquatone/aquatone /usr/bin/aquatone


# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache
