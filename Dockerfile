FROM python:3.8

COPY requirements.txt /requirements.txt
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip config set global.index-url https://pypi.douban.com/simple
WORKDIR /
RUN /usr/local/bin/python -m pip install -r requirements.txt

COPY init.sh /init.sh
RUN chmod +x /init.sh

RUN mkdir /srv/site
VOLUME /srv/site
WORKDIR /srv/site

EXPOSE 8080
HEALTHCHECK CMD curl http://127.0.0.1:8080

ENTRYPOINT ["/init.sh"]
CMD ["serve", "--dev-addr=0.0.0.0:8080"]
