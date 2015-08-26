FROM golang

RUN apt-get update
RUN apt-get install -y fuse

RUN go get -u github.com/ipfs/go-ipfs/cmd/ipfs

RUN mkdir /ipfs/
COPY entrypoint.sh /ipfs/

EXPOSE 4001

CMD ["/ipfs/entrypoint.sh"]
