# From: https://hub.docker.com/r/andyshinn/dnsmasq

FROM yvesbd/docker-alpine-base

# openntpd
ENV DNSFORWARD=9.9.9.9
ENV LOGFILE=/var/log/dnsmasq/dnsmasq.log

RUN apk --no-cache add dnsmasq logrotate

EXPOSE 53 53/udp
VOLUME /var/log/dnsmasq

COPY dnsmasq.conf /etc/
COPY logrotate-dnsmasq.conf /etc/logrotate.d/dnsmasq
# COPY start.sh /
# RUN chmod +x /start.sh

RUN chmod -R 777 /var/log/dnsmasq

ENTRYPOINT echo server=`getent hosts dnsquad9 | cut -d" " -f 1`#8053 >> /etc/dnsmasq.d/server.conf && \
           cp -f /etc/dnsmasq.conf /var/log/dnsmasq  && \
           cp -f /etc/dnsmasq.d/* /var/log/dnsmasq  && \
           dnsmasq -k --log-facility=${LOGFILE}

# ENTRYPOINT ["/start.sh"]
# CMD /start.sh
# log-facility=
# CMD cat /etc/resolv.conf
# CMD tail -f /var/log/dnsmasq/dnsmasq.log
# --server=${DNSFORWARD} 
# docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --volumes-from dnsmasq_log -e DNSFORWARD=1.1.1.1 -it dnsmasq 