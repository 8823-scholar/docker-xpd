FROM xpjp/xpd:latest

LABEL maintainer "KIUCHI Satoshinosuke <scholar@hayabusa-lab.jp>"

ENV XPD_RPC_PASSWORD password
ENV XPD_RPC_ALLOW_IP 0.0.0.0/0
ENV XPD_TESTNET 1

USER root
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 17778

USER wallet
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/XPd", "-printtoconsole"]
