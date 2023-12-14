#!/bin/bash

for non_b in "STR" "MR" "IR" "DR" "APR" "GQ" "Z" "all"
do

  echo "non_b: ${non_b}"
  for i in `seq 1 2 22`;
  do
    echo "chromosome num: $i"
    echo "chromosome num: $((i+1))"
    Rscript ./scripts/horizontal_bar_plot.R F F F "plots/${non_b}_new_onto_old_${i}_$((i+1)).svg" ${non_b} ./non_b_v2/${non_b} dip.20221111_${i}_$((i+1)).lengths chrom_to_density_${i}_$((i+1)).dat chrom_to_plot_label_${i}_$((i+1)).dat;
  done

  Rscript ./scripts/horizontal_bar_plot.R F F F "plots/${non_b}_new_onto_old_X_Y.svg" ${non_b} ./non_b_v2/${non_b} dip.20221111_X_Y.lengths chrom_to_density_X_Y.dat chrom_to_plot_label_X_Y.dat;

done
