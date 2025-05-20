# Evoultionary_bioinformatics_5
Este repositorio contiene los datos y el código necesarios para la realización de la práctica 5 de Bioinformática Evolutiva.
En el archivo comprimido 9_TB_alignments se encuentran las secuencias multifasta proporcionadas, tanto de los genes a estudiar como de su concatenación para cada especie, creando el genoma core.
El resto de archivos `.sh` contienen el código para generar distintos archivos de análisis de modelo, filogenia mediante máxima verosimilitud y topología de los genes, así como la generación de un archivo de texto (`modelos.txt`) con el modelo de sustitución nucleotídica para cada gen, y un csv resumen de los parámetros y test estadísticos analizados (`resumen_filogenico.csv`). También genera imagenes `.svg` de triángulos de mapeado de verosimilitud.

Para un correcto funcionamiento debe crearse un directorio con todos estos archivos y descomprimir la carpeta de alineamientos. Posteriormente pueden ejecutarse en la terminal de `bash`los siguientes comandos:
`
./topology.sh
./resultados.sh
`
