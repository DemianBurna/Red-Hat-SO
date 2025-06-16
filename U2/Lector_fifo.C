// lector_fifo.c
#include <stdio.h>     // Libreria de Entrada/salida estándar en C: printf, scanf, fopen, fclose
#include <fcntl.h>     // Libreria de Control de archivos: open, creat, flags como O_RDONLY, O_WRONLY
#include <unistd.h>    // Libreria de Llamadas al sistema UNIX: read, write, close, fork, exec, etc.
#include <sys/file.h>  // Libreria para que el codigo entienda comandos de redhat descritos en la carpeta informda en el include

int main() {
    int fd = open("/tmp/mi_fifo", O_RDONLY);  // Abre el FIFO en modo solo lectura
    char buffer[100];                         // Buffer para almacenar datos leídos
    read(fd, buffer, sizeof(buffer));         // Lee datos del FIFO al buffer
    printf("FIFO: %s\n", buffer);            // Muestra los datos leídos
    return 0;
}