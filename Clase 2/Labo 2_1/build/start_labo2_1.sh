#!/bin/sh

# Formato de creacion de usuarios.
# USERS='name1|password1|[folder1][|uid1] name2|password2|[folder2][|uid2]'
# 
# Los parametros entre [] son opcionales.

# Si no tengo ningun usuario en el ambiente, defino uno por defecto.
if [ -z "$USERS" ]; then
  USERS="ftp|alpine"
fi

# Recorro los usuarios.
for i in $USERS ; do
  # Obtengo los datos.
  NAME=$(echo $i | cut -d'|' -f1)
  PASS=$(echo $i | cut -d'|' -f2)
  FOLDER=$(echo $i | cut -d'|' -f3)
  UID=$(echo $i | cut -d'|' -f4)

  # Si no tiene carpeta, se la creo
  if [ -z "$FOLDER" ]; then
    FOLDER="/ftp/users/$NAME"
  fi

  # Si se le definio un user ID, lo asigno.
  if [ ! -z "$UID" ]; then
    UID_OPT="-u $UID"
  fi

  # Creo la carpeta del usuario y el usuario.
  mkdir -p $FOLDER
  echo -e "$PASS\n$PASS" | adduser -h $FOLDER -s /bin/sh -g ftp $UID_OPT $NAME
  chown -R $NAME:$NAME $FOLDER

  # Limpio.
  unset NAME PASS FOLDER UID
done

# Configuraciones del rango de puertos de FTP.
if [ -z "$MIN_PORT" ]; then
  MIN_PORT=21000
fi
if [ -z "$MAX_PORT" ]; then
  MAX_PORT=21010
fi

# Configuracion de las direcciones extra (Si las hubieran).
if [ ! -z "$ADDRESS" ]; then
  ADDR_OPT="-opasv_address=$ADDRESS"
fi

# Iniciamos SFTP.
/usr/sbin/vsftpd -opasv_min_port=$MIN_PORT -opasv_max_port=$MAX_PORT $ADDR_OPT /etc/vsftpd/vsftpd.conf

# Iniciamos apache (Ligado al contenedor).
exec /usr/sbin/httpd -D FOREGROUND