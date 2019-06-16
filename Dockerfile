#IMAGE NGINX AND PHP
FROM richarvey/nginx-php-fpm:latest

ADD host.conf /etc/nginx/sites-available/default.conf
ADD nginx.conf /etc/nginx/nginx.conf

ENV WEBROOT /var/www/html/public

ENV APP_HOME /var/www/html
RUN rm -Rf /var/www/html/*

ADD . $APP_HOME

RUN composer install
RUN php artisan key:generate
RUN php artisan jwt:secret

RUN php artisan cache:clear
RUN php artisan config:cache

RUN chown -R nginx:nginx $APP_HOME
