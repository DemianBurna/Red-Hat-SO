#!/bin/bash

echo "Diagnóstico de procesos interbloqueados y lector bloqueado en FIFO"
echo "----------------------------------------------------------------------"

# Buscar procesos relacionados
PIDS=$(ps -eo pid,comm | grep -E 'proceso_A|proceso_B|lector_fifo' | awk '{print $1}')

if [ -z "$PIDS" ]; then
    echo "No se encontraron procesos proceso_A, proceso_B o lector_fifo corriendo."
    exit 1
fi

for PID in $PIDS; do
    echo "Análisis del proceso PID: $PID"

    echo "-----------------------------"
    
    echo "Estado y wchan:"
    ps -p "$PID" -o pid,state,wchan,comm

    echo "-----------------------------"

    echo "Archivos abiertos:"
    lsof -p "$PID" 2>/dev/null || echo "   No se pudieron leer archivos abiertos   (requiere permisos)."

    echo "-----------------------------"

    echo "Bloqueos activos del sistema asociados:"
    lslocks | grep " $PID " || echo "   No se encontraron bloqueos para este proceso."

    echo "-----------------------------"

    echo "Descriptores de archivo:"
    ls -l /proc/"$PID"/fd 2>/dev/null || echo "   No se pudo acceder a /proc/$PID/fd."

    echo "-----------------------------"
    
    echo "Si está esperando flock:"
    sudo strace -p "$PID" -e trace=flock -f -tt -qq 2>&1 | head -n 3 || echo "   No se pudo ejecutar strace (requiere permisos)."
   
    echo "-----------------------------"
done

echo "Diagnóstico finalizado."
