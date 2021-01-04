FROM jekyll/jekyll
RUN gem install jekyll-scholar

USER root

RUN echo "ipv6" >> /etc/modules
RUN sed -i -e 's/v3\.7/edge/g' /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update
RUN apk add texlive
RUN apk add texlive-full

RUN apk add cairo-dev cairo
RUN apk add poppler-dev poppler
RUN wget https://github.com/dawbarton/pdf2svg/archive/v0.2.3.tar.gz &&\
      tar -zxf *.tar.gz &&\
      cd pdf2svg-0.2.3 &&\
      ./configure --prefix=/usr/local &&\
      make -j`nproc`&&\
      make install -j`nproc`

ENV PATH /usr/local/bin:$PATH

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
