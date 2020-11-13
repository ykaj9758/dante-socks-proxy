FROM ubi7:latest
RUN useradd -M sockd  && mkdir /tmp/dante && curl -L -L https://www.inet.no/dante/sslfiles/dante-1.4.2/tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz | tar xz -C /tmp/dante && mv /tmp/dante/usr /opt/dante && rmdir /tmp/dante && mkdir -p /opt/dante/etc && yum -y install net-tools && yum install -y nmap
COPY sockd.conf /opt/dante/etc
RUN mkdir -p /opt/dante/run && chown -R sockd:sockd /opt/dante && chmod -R 755 /opt/dante
USER sockd
EXPOSE 1080
CMD ["/opt/dante/sbin/sockd","-f/opt/dante/etc/sockd.conf","-p/opt/dante/run/sockd.pid"]
