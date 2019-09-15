FROM alpine:latest

# Instalaciones necesarias
RUN apk add --no-cache apache2-proxy apache2-ssl apache2-utils apache2-ctl curl logrotate openssl
RUN apk --no-cache add vsftpd
RUN apk --no-cache add openrc

# Cargamos el archivo que ejecuta la magia
COPY start_labo2_1.sh /bin/start_labo2_1.sh

# Cargamos los archivos que hacen falta para cada servicio
## Configuracion del FTP y de apache
COPY ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY sites.conf /etc/apache2/conf.d/sites.conf
## Agregamos los archivos de los sitios existentes y el dummy del nuevo sitio
ADD sitio1/html/* /ftp/users/sitio1/webroot/
ADD sitio2/html/* /ftp/users/sitio2/webroot/
ADD nuevo/html/* /ftp/users/nuevo/webroot/

# Abrimos puertos
EXPOSE 21 21000-21010
EXPOSE 80

CMD "/bin/start_labo2_1.sh"
