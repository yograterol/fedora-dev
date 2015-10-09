FROM fedora
MAINTAINER Yohan Graterol <y@platzi.com>

EXPOSE 22

RUN yum -y install \
	openssh-server \
	passwd \
	; yum clean all

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
