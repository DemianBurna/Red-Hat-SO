#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# ruta base del usuario actual
BASE_DIR="$HOME"

echo "creando estructura de directorios..."
mkdir -p "$BASE_DIR/trabajo/proyectos"
mkdir -p "$BASE_DIR/trabajo/documentos"
mkdir -p "$BASE_DIR/backup"

echo "creando archivos de ejemplo..."
echo "informe del proyecto x" > "$BASE_DIR/trabajo/proyectos/informe.txt"
echo "datos confidenciales" > "$BASE_DIR/trabajo/documentos/privado.txt"

echo "moviendo y copiando archivos..."
mv "$BASE_DIR/trabajo/documentos/privado.txt" "$BASE_DIR/trabajo/proyectos/"
cp "$BASE_DIR/trabajo/proyectos/informe.txt" "$BASE_DIR/trabajo/documentos/informe_copia.txt"

echo "redireccionando salida de listado..."
ls -lh "$BASE_DIR/trabajo/proyectos" > "$BASE_DIR/trabajo/listado.txt"

echo "creando archivo tar comprimido..."
tar -czvf "$BASE_DIR/backup/backup_trabajo.tar.gz" -C "$BASE_DIR" trabajo

echo "consultando uso de disco:"
du -sh "$BASE_DIR/trabajo"
du -sh "$BASE_DIR/backup"

echo "simulando servidor remoto..."
mkdir -p "$BASE_DIR/servidor_simulado/tomas_backup"

echo "sincronizando con carpeta remota simulada..."
rsync -avh "$BASE_DIR/backup/backup_trabajo.tar.gz" "$BASE_DIR/servidor_simulado/tomas_backup/"

echo "verificando contenido del servidor simulado..."
ls -lh "$BASE_DIR/servidor_simulado/tomas_backup/"

echo "todo listo. proceso completado con éxito"
