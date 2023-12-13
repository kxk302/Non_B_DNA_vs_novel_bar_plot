#!/bin/bash

for i in `seq 1 2 22`;
do
  echo $i $((i+1));
  Rscript ./scripts/horizontal_bar_plot.R F F F "plots/all_new_onto_old_${i}_$((i+1)).svg" all ./non_b_v2/all dip.20221111_${i}_$((i+1)).lengths chrom_to_density_${i}_$((i+1)).dat chrom_to_plot_label_${i}_$((i+1)).dat;
done

Rscript ./scripts/horizontal_bar_plot.R F F F "plots/all_new_onto_old_X_Y.svg" all ./non_b_v2/all dip.20221111_X_Y.lengths chrom_to_density_X_Y.dat chrom_to_plot_label_X_Y.dat;

#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/STR_new_onto_old.svg" STR ./non_b/STR;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/MR_new_onto_old.svg" MR ./non_b/MR;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/IR_new_onto_old.svg" IR ./non_b/IR;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/DR_new_onto_old.svg" DR ./non_b/DR;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/APR_new_onto_old.svg" APR ./non_b/APR;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/GQ_new_onto_old.svg" GQ ./non_b/GQ;
#Rscript ./scripts/horizontal_bar_plot.R F F F "plots/Z_new_onto_old.svg" Z ./non_b/Z;
