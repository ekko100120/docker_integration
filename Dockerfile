FROM ubuntu:latest
MAINTAINER Kenny <411316753@qq.com>
RUN apt-get update
RUN apt-get  install -y python-pip
RUN apt-get  install -y python-setuptools
RUN apt-get  install -y supervisor
RUN apt-get install -y  nginx
#echo_supervisord_conf export supervisord config
RUN echo_supervisord_conf > /etc/supervisord.conf

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/helloWorld.conf /etc/nginx/helloWorld.conf
COPY ./supervisor/supervisord.conf /tmp/supervisord.conf
RUN cat /tmp/supervisord.conf >> /etc/supervisord.conf && \
    rm /tmp/supervisord.conf

COPY ./src /flask-helloWorld
COPY ./requirements.txt /flask-helloWorld/requirements.txt

WORKDIR /flask-helloWorld

RUN pip install -r requirements.txt

EXPOSE 8888

#CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]
ENTRYPOINT ["python"]
CMD ["helloWorld.py"]