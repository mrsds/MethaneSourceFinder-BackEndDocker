FROM continuumio/anaconda
COPY . /msf
WORKDIR /msf

RUN bash -c 'apt update'
RUN bash -c 'apt-get install -y build-essential'
RUN bash -c 'apt-get install -y autoconf automake gdb git libffi-dev zlib1g-dev libssl-dev'
RUN bash -c 'conda install -y gdal && cd /msf && python setup.py install'

ARG ENVIRONMENT_NAME
ENV ENVIRONMENT_NAME=$ENVIRONMENT_NAME

CMD sh run-msf-be.sh 

EXPOSE 8001/tcp
