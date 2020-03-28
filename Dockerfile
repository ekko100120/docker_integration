FROM centos:latest
MAINTAINER Kenny <411316753@qq.com>
RUN yum -y update; yum clean all
RUN yum -y install python-setuptools
RUN yum -y install nginx && \
    easy install pip supervisor && \
    # echo_supervisord_conf export supervisord config
    echo_supervisord_conf > /etc/supervisord.conf

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/helloWorld.conf /etc/nginx/helloWorld.conf
COPY ./supervisor/supervisord.conf /tmp/supervisord.conf
RUN cat /tmp/supervisord.conf >> /etc/supervisord.conf && \
    rm /tmp/supervisord.conf

COPY ./src /flask-helloWorld
WORKDIR /flask-helloWorld

RUN pip install -r requirements.txt

EXPOSE 9999

CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]