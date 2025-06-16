#!/bin/bash
#En este script se detallan los comandos para una configuración inicial de los laboratorios

#1. Listado de usuarios
ls /home

#2. Creación de usuario de laboratorio (en caso de no existir)
if [[ ! -d "/home/laboratorio" ]]; then
    useradd laboratorio
    #Configuración de contraseña "laboratorio"
    echo "laboratorio:laboratorio" | sudo chpasswd
    echo -e "\nSe ha configurado el usuario 'laboratorio', contraseña 'laboratorio'."
fi

#3. Imprimir la fecha del sistema
echo -e "\nFecha del sistema:"
date
#Actualización de la fecha del sistema
echo -e "\n¿Desea actualizar la fecha del sistema? presione 1, de lo contrario presione 0: "
read updateDate

if [[ $updateDate -eq 1 ]]; then
    echo -e "Especifique la nueva fecha: "
    read newDate
    sudo date --set=$newDate
    if [[ $? -eq 0 ]]; then
        echo -e "\nFecha actualizada correctamente."
    else
        echo -e "\nError al actualizar la fecha."
    fi
fi

#4. Imprimir la versión de Red Hat
echo -e "\nVersión de Red Hat:"
cat /etc/redhat-release

#5. Verificación de conexión a Internet
echo -e "\nVerificando conexión a Internet..."
ping -c 3 8.8.8.8 #Ping a DNS de Google (solo 3 paquetes)

# Eliminar usuario laboratorio: userdel -r laboratorio
# Actualizar fecha: date --set="YYYY-MM-DD HH:MM:SS"
