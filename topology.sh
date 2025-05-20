#!/bin/bash

# Directorio con los datos
files=(./9_TB_alignments/*.fasta)

echo -e "Modelo para cada gen:" > modelos.txt

# Preparamos primero el core que se usa como referencia
iqtree2 -s ./9_TB_alignments/core.fasta -m TEST -pre "core.MODEL"
model=$(grep "Best-fit model according to BIC:" "core.MODEL.iqtree" | awk '{print $NF}')
echo "El modelo para el genoma core es $model." >> modelos.txt
iqtree2 -s ./9_TB_alignments/core.fasta -lmap ALL -n 0 -m "$model"

for file in "${files[@]}"; do
    gen=$(basename "$file" .fasta)
    if [ "$gen" != "core" ]; then

    # Encontrar modelo
    iqtree2 -s "$file" -m TEST -pre "$gen.MODEL"

    model=$(grep "Best-fit model according to BIC:" "$gen.MODEL.iqtree" | awk '{print $NF}')

    echo "El modelo para el gen $gen es $model." >> modelos.txt

    # Reconstruir árbol 
    iqtree2 -s "$file" -lmap ALL -n 0 -m "$model"

    # Comparar con el genoma core
    
        cat core.MODEL.treefile "$gen.MODEL.treefile" > "TOPO_core_${gen}.dnd"
        iqtree2 -s "$file" -z "TOPO_core_${gen}.dnd" -n 0 -m "$model" -zb 100000 -zw -au -pre "FINAL_${gen}"
    fi
done



# Encontrar modelo (1)
#iqtree2 -s file  TEST -pre MODEL
# Esto con core y genes
# Cambias file cada vez

# Reconstruir árbol (2)
#iqtree2 -s file -lmap ALL -n 0 -m model
# Con core y genes
# Cambias file y model cada vez

# Concatenar core con el gen (3)
# Esto le añadiría antes un if $file != core.fasta
#cat core.MODEL.treefile gen.MODEL.treefile > TOPO_core_gen.dnd
# Cambiar gen cada vez

# Topology test analysis (4)
#iqtree2 -s gen.fasta -z TOPO_core_gen.dnd -n 0 -m model -nb 10000 -zw -au -pre FINAL (-redo)
# Cambiar gen y model cada vez
