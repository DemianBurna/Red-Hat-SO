// proceso_B.c
#include <stdio.h>     // Libreria de Entrada/salida estándar en C: printf, scanf, fopen, fclose
#include <fcntl.h>     // Libreria de Control de archivos: open, creat, flags como O_RDONLY, O_WRONLY
#include <unistd.h>    // Libreria de Llamadas al sistema UNIX: read, write, close, fork, exec, etc.
#include <sys/file.h>  // Libreria para que el codigo entienda comandos de redhat descritos en la carpeta informda en el include

int main() {
    int fb = open("/tmp/lockB", O_RDWR);      // Abre archivo lockB para lectura/escritura
    flock(fb, LOCK_EX);    // Bloquea exclusivamente lockB
    sleep(5);  

    int fa = open("/tmp/lockB", O_RDWR);      // Abre archivo lockA para lectura/escritura
    flock(fa, LOCK_EX);     // Esperará porque A ya tiene lockA - INTERBLOQUEO

    printf("Proceso B terminó.\n");           // Nunca se ejecutará hasta que se liberen los bloqueos
    return 0;
}
