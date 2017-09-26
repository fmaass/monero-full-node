# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.11.0.0.tar.bz2 -O &&\
  echo 'fa7742c822f3c966aa842bf20a9920803d690d9db02033d9b397cefc7cc07ff4  monero-linux-x64-v0.11.0.0.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.11.0.0.tar.bz2 &&\
  rm monero-linux-x64-v0.11.0.0.tar.bz2 &&\
  cp ./monero-v0.11.0.0/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--rpc-bind-ip=0.0.0.0", "--confirm-external-bind", "--fast-block-sync=1"]