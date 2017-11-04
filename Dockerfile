# redsocks is available only as a DEB package
FROM ubuntu:16.04

RUN apt-get update \
 && apt-get upgrade -qy

RUN apt-get install -qy sudo cntlm redsocks wget

EXPOSE 3128
EXPOSE 3129

RUN useradd -m -d /home/ntlm_proxy_user -s /bin/bash -u 3129 ntlm_proxy_user
RUN usermod -aG sudo ntlm_proxy_user
RUN echo 'ntlm_proxy_user ALL=NOPASSWD: ALL' >> /etc/sudoers

ADD cntlm.conf /home/ntlm_proxy_user/cntlm.conf
ADD redsocks.conf /home/ntlm_proxy_user/redsocks.conf
ADD startup.sh /home/ntlm_proxy_user/startup.sh
RUN chown ntlm_proxy_user /home/ntlm_proxy_user/*
RUN chmod +x /home/ntlm_proxy_user/*.sh

USER ntlm_proxy_user
ENV HOME /home/ntlm_proxy_user
CMD [ "/home/ntlm_proxy_user/startup.sh" ]
