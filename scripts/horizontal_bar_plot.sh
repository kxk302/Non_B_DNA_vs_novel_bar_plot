#!/bin/bash

Rscript ./scripts/horizontal_bar_plot.R F F F "plots/STR_new_onto_old.svg" STR ./non_b/STR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/MR_new_onto_old.svg" MR ./non_b/MR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/IR_new_onto_old.svg" IR ./non_b/IR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/DR_new_onto_old.svg" DR ./non_b/DR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/APR_new_onto_old.svg" APR ./non_b/APR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/GQ_new_onto_old.svg" GQ ./non_b/GQ;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/Z_new_onto_old.svg" Z ./non_b/Z;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/all_new_onto_old.svg" all ./non_b/all;
