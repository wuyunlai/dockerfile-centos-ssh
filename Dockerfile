#Dockerfile centos-ssh
# ѡ��һ�����е�os������Ϊ����
FROM centos:latest

# ���������
MAINTAINER wuyl

# ��װopenssh-server��sudo����������ҽ�sshd��UsePAM�������ó�no
RUN yum install -y openssh-server sudo nano
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

#��װopenssh-clients
RUN yum install -y openssh-clients

# ��Ӳ����û�root������root�����ҽ����û���ӵ�sudoers��
RUN echo "root:root" | chpasswd
RUN echo "root ALL=(ALL) ALL" >> /etc/sudoers

# ����������Ƚ����⣬��centos6�ϱ���Ҫ�У����򴴽�����������sshd���ܵ�¼
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# ����sshd�����ұ�¶22�˿�
RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
