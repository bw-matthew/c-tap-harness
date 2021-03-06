FROM ubuntu

RUN apt-get update --fix-missing
RUN apt-get install -y build-essential autoconf shtool libtool

ADD . /project
WORKDIR /project

RUN ./autogen
RUN ./configure
RUN make
RUN make install
