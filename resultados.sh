#!/bin/bash

files=(./9_TB_alignments/*.fasta)

echo -e "GEN;MODELO;%_STAR_LIKE;logL;DeltaL;bp Rell;p-KH;p-SH;p-WKH;p-WSH;c-ELW;p-AU" > resumen_filogenico.csv

for file in "${files[@]}"; do
    if [ "$(basename "$file" .fasta)" != "core" ]; then
        gen=$(basename "$file" .fasta)
        model=$(grep "Best-fit model according to BIC:" "$gen.MODEL.iqtree" | awk '{print $NF}')
        starlike=$(grep -A 1 "moveto % center" "./9_TB_alignments/$gen.fasta.lmap.eps" | grep -oP '\(\K[0-9.]+(?=%)')
        final_file="FINAL_$gen.iqtree"
        table_start=$(grep -n "Tree      logL" "$final_file" | cut -d: -f1)
        stats_line=$(tail -n +"$table_start" "$final_file" | awk '/^[[:space:]]+1 / {print; exit}')

        if [ -n "$stats_line" ]; then
            logL=$(echo "$stats_line" | awk '{print $2}')
            DeltaL=$(echo "$stats_line" | awk '{print $3}')
            BP_RELL=$(echo "$stats_line" | awk '{print $4}')
            p_KH=$(echo "$stats_line" | awk '{print $6}')
            p_SH=$(echo "$stats_line" | awk '{print $8}')
            p_WKH=$(echo "$stats_line" | awk '{print $10}')   
            p_WSH=$(echo "$stats_line" | awk '{print $12}')
            c_ELW=$(echo "$stats_line" | awk '{print $14}')   
            p_AU=$(echo "$stats_line" | awk '{print $16}')    
        fi

        echo "$gen;$model;$starlike;$logL;$DeltaL;$BP_RELL;$p_KH;$p_SH;$p_WKH;$p_WSH;$c_ELW;$p_AU" >> resumen_filogenico.csv
    else
        gen=$(basename "$file" .fasta)
        model=$(grep "Best-fit model according to BIC:" "$gen.MODEL.iqtree" | awk '{print $NF}')
        starlike=$(grep -A 1 "moveto % center" "./9_TB_alignments/$gen.fasta.lmap.eps" | grep -oP '\(\K[0-9.]+(?=%)')

        echo "$gen;$model;$starlike;-;-;-;-;-;-;-;-;-" >> resumen_filogenico.csv
    fi
done