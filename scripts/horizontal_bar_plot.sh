#!/bin/bash

Rscript ./scripts/horizontal_bar_plot.R F F F "plots/STR_new_onto_old.pdf" STR ./non_b/STR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/MR_new_onto_old.pdf" MR ./non_b/MR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/IR_new_onto_old.pdf" IR ./non_b/IR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/DR_new_onto_old.pdf" DR ./non_b/DR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/APR_new_onto_old.pdf" APR ./non_b/APR;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/GQ_new_onto_old.pdf" GQ ./non_b/GQ;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/Z_new_onto_old.pdf" Z ./non_b/Z;
Rscript ./scripts/horizontal_bar_plot.R F F F "plots/all_new_onto_old.pdf" all ./non_b/all;
