FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y shellinabox \
    openssh-server passwd net-tools vim wget curl lsof git \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN mv  /etc/ssh/ssh_host* /tmp/

RUN ssh-keygen -q -t rsa -b 2048 -f /root/.ssh/id_rsa -N ''
RUN sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config \
&& echo 'Port 2222' >> /etc/ssh/sshd_config \
&& echo 'UseDNS no' >> /etc/ssh/sshd_config \
&& ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
&& ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
&& ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' \
&& ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''


RUN sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config \
&& echo 'UseDNS no' >> /etc/ssh/sshd_config && echo 'Port 2222' >> /etc/ssh/sshd_config  && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "root:passw0rd123!@#" | chpasswd  

RUN mkdir /var/run/sshd

RUN useradd -m -d /home/web web 
RUN echo "web:passw0rd123!@#" | chpasswd  

COPY start.sh /start.sh 
RUN chmod a+x /start.sh



#CMD ["/usr/sbin/init"]
#CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
#CMD ["/start.sh"]
CMD ["sh", "-c", "/start.sh"]
