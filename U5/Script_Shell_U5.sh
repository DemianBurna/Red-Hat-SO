#!/bin/sh

#Definición del archivo en donde se almacenará la información
TIMESTAMP=`date +%s` #Obtiene la fecha como timesamp unix
INFORME="/home/student/scripts/informe_${TIMESTAMP}.log" #Se guarda en una variable la ruta del archivo

#Funcionamiento: A meidda que se ejecutan los comandos, se van guardando en el archivo especificado
echo -e "Información general del sistema:\n" >> $INFORME
hostnamectl >> $INFORME

#Lista el uso de memoria
echo -e "\nMemoria: \n" >> $INFORME
free -h >> $INFORME

#Lista todos los discos disponibles, incluyendo particiones
echo -e "\nDispositivos de almacenamiento:\n" >> $INFORME
lsblk >> $INFORME

#Lista todos los dispositivos montados y sus puntos de montaje
echo -e "\nDispositivos montados:\n" >> $INFORME
df -h >> $INFORME

#Lista los USB conectados en caso de haberlos
echo -e "\nUSB conectados:\n" >> $INFORME
lsusb >> $INFORME

#Lista los dispositivos PCI conectados
echo -e "\nDispositivos PCI:\n" >> $INFORME
lspci >> $INFORME

#Se verifica que el archivo se haya creado 
if [[ -f $INFORME ]]; then
    echo -e "\nSe ha guardado una copia de la configuración en el archivo $INFORME"
    echo -e "\nImprimiendo configuración...\n"
    cat $INFORME
else
    echo -e "\nOcurrió un error, el archivo no pudo crearse."
fi