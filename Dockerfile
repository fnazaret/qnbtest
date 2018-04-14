FROM ubuntu:14.04

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 python-pip \
        libapache2-mod-wsgi \
        libmysqlclient-dev \
        python-dev
RUN pip install flask
RUN pip install flask-mysql
ADD app /var/www/myflaskapp
ADD conf/myflaskapp.conf /etc/apache2/sites-available/myflaskapp.conf
RUN a2dissite 000-default
RUN a2ensite myflaskapp
ADD conf/servername.conf /etc/apache2/conf-available/servername.conf
RUN a2enconf servername
ENTRYPOINT ["apache2ctl","-D","FOREGROUND"]
