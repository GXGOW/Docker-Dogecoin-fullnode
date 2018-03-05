FROM debian:latest
ADD init.sh /
EXPOSE 9333
ENTRYPOINT ["/bin/bash"]
CMD ["/init.sh"]
LABEL name="litecoin-node" version="1.2" description="Litecoin fullnode container based off Ubuntu"