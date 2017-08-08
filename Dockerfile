FROM ubuntu
ADD init.sh /
ADD litecoin.gz /root
ENTRYPOINT ["/bin/bash"]
CMD ["/init.sh"]