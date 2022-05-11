FROM ubuntu:latest
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update \
	&& apt-get install -y php7.4-dev libevent-dev libssl-dev git pkg-config php-pear
RUN yes '' | pecl install event eio
RUN echo "extension=event.so" >> /etc/php/7.4/cli/conf.d/event.ini \
	&& echo "extension=eio.so" >> /etc/php/7.4/cli/conf.d/eio.ini 
RUN git clone https://github.com/kakserpom/phpdaemon.git /usr/share/phpdaemon
COPY phpd.conf /etc/phpd/phpd.conf
VOLUME /Projects