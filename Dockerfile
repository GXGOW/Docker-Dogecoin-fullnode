FROM ubuntu
ADD init.sh /
ADD litecoin.gz /root
EXPOSE 9333
ENTRYPOINT ["/bin/bash"]
CMD ["/init.sh"]
LABEL name="litecoin-node" version="1.1" description="Litecoin fullnode container based off Ubuntu"