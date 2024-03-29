To generate the horizontal bar plot, after cloning the repo, perform the following operations (For location of the data files used, please contact @kxk302):

1. Create a folder called 'new_onto_old'. For each species and each chromosome, copy the file that specifies which section of the T2T sequence maps to an existing (non-T2T) sequence. These are the aligned-intervals files. They are three-column files with each line being <chromosome_name> <start> <end>, where the interval is origin-zero half-open; there should not be any overlapping intervals. For example, copy the following files to 'new_onto_old' folder:

gorGor.chrX.new_onto_old.winnowmap.covered.dat.gz
gorGor.chrY.new_onto_old.winnowmap.covered.dat.gz
panPan.chrX.new_onto_old.winnowmap.covered.dat.gz
panPan.chrY.new_onto_old.winnowmap.covered.dat.gz
panTro.chrX.new_onto_old.winnowmap.covered.dat.gz
panTro.chrY.new_onto_old.winnowmap.covered.dat.gz
ponAbe.chrX.new_onto_old.winnowmap.covered.dat.gz
ponAbe.chrY.new_onto_old.winnowmap.covered.dat.gz

2. Create a folder called 'non_b'. In 'non_b' folder create a folder for each non-B DNA type. Use the following non-B DNA acronyms for folder names (APR, DR, GQ, IR, MR, STR, Z). In 'non-b' folder, also create a folder called 'all' for all non-B DNA types. In each of these sub-folders, create a 'data' folder. 

non_b
├── APR
│   └── data
├── DR
│   └── data
├── GQ
│   └── data
├── IR
│   └── data
├── MR
│   └── data
├── STR
│   └── data
├── Z
│   └── data
└── all
    └── data

3. Copy non-B DNA density files to appropriate folder. These are the four column windowed density files. They have a header line: chr start stop count. For example, for APR non-B DNA, copy the following files to 'non_b/APR/data' folder. Repeat for all non-B DNA types.

Gorilla_gorilla_chr1_APR_density_final.bed
Gorilla_gorilla_chr2_APR_density_final.bed
...
Gorilla_gorilla_chrX_APR_density_final.bed
Gorilla_gorilla_chrY_APR_density_final.bed
Homo_sapiens_chr1_APR_density_final.bed
Homo_sapiens_chr2_APR_density_final.bed
...
Homo_sapiens_chrX_APR_density_final.bed
Homo_sapiens_chrY_APR_density_final.bed
Pan_paniscus_chr1_APR_density_final.bed
Pan_paniscus_chr2_APR_density_final.bed
...
Pan_paniscus_chrX_APR_density_final.bed
Pan_paniscus_chrY_APR_density_final.bed
Pan_troglodytes_chr1_APR_density_final.bed
Pan_troglodytes_chr2_APR_density_final.bed
...
Pan_troglodytes_chrX_APR_density_final.bed
Pan_troglodytes_chrY_APR_density_final.bed
Pongo_abelii_chr1_APR_density_final.bed
Pongo_abelii_chr2_APR_density_final.bed
...
Pongo_abelii_chrX_APR_density_final.bed
Pongo_abelii_chrY_APR_density_final.bed
Pongo_pygmaeus_chr1_APR_density_final.bed
Pongo_pygmaeus_chr2_APR_density_final.bed
...
Pongo_pygmaeus_chrX_APR_density_final.bed
Pongo_pygmaeus_chrY_APR_density_final.bed
Symphalangus_syndactylus_chr1_APR_density_final.bed
Symphalangus_syndactylus_chr2_APR_density_final.bed
...
Symphalangus_syndactylus_chrX_APR_density_final.bed
Symphalangus_syndactylus_chrY_APR_density_final.bed

4. The 'data' folder has the following files. Their description is given below.

data/dip.20221111_<ChromosomeNum>_<ChromosomeNum>.lengths
- There is one file for each chromosome pair, (1,2), (3,4), ..., (X,Y)
- List of <chromosome_name> <length> <label>, one per line
- chromosome_name should contain the name of the individual as a prefix
  E.g., chm13 or mPanTro3. So, for example something like chm13.chrX or mPanTro3.chrY
- Order in this file determines order that bars are plotted

data/chrom_to_alignment.dat
- List of <chromosome_name> <alignment_name>, one per line
- This maps from the name of the individual to the base name of the corresponding aligned-intervals file
  E.g., mGorGor1.chrX gorGor.chrX
- If a particular <chromosome_name> doesn't exist in this file, it's aligned-intervals bar is drawn as being all novel sequence
- chm13.chrX and hg002.chrY are hard-wired special cases for which the aligned-intervals bar is drawn as being all pre-existing sequence

data/chrom_to_density_<ChromosomeNum>_<ChromosomeNum>.dat
- There is one file for each chromosome pair, (1,2), (3,4), ..., (X,Y)
- List of <chromosome_name> <density_name>, one per line
- This maps from the name of the individual to the base name of the corresponding density file
  E.g., mGorGor1.chrX Gorilla_gorilla_chrX

data/chrom_to_plot_label_<ChromosomeNum>_<ChromosomeNum>.dat
- There is one file for each chromosome pair, (1,2), (3,4), ..., (X,Y)
- List of <chromosome_name> <plot_label>, one per line
- This maps from the name of the individual to the plot label in horizontal bar plot for novel sequence 
  E.g., mGorGor1.chrX Gorilla_chrX
 
5. In the 'scripts' folder, there is an R script that generates a bar plot. The script takes 9 input parameters:

First argument: inhibitAlignmentFill = T/F
Second argument: inhibitDensityFill = T/F
Third argument: useSubsetOfSpecies = T/F. If F, will plot the horizontal bar for species we have no T2T info on
                                          If T, those species are excluded from the bar plot  
Forth argument: plotFilenameTemplate = NULL: will plot using quartz (Only works on Mac)
                                       Or, plot file name. E.g., './plots/STR_new_onto_old.pdf' (Must create a 'plots' folder)
Fifth argument: non_B_DNA_Type. Allowed values: GQ MR STR APR IR DR Z.
Sixth argument: non_B_DNA_Folder. E.g., './non_b/STR' for STR non-B DNA type
Seventh argument: name of the dip.20221111_<ChromosomeNum>_<ChromosomeNum>.lengths file
Eight argument: name of the chrom_to_density_<ChromosomeNum>_<ChromosomeNum>.dat file
Ninth argument: name of the chrom_to_plot_label_<ChromosomeNum>_<ChromosomeNum>.dat

6. In the 'scripts' folder, there is a shell script, horizontal_bar_plot.sh, that call the R script for all
   non-B DNA types (STR, MR, IR, DR, APR, GQ, A, and all) and all chromosome pairs, and generates their bar
   plot in 'plots' folder (e.g., GQ_new_onto_old_1_2.svg, GQ_new_onto_old_1_2.svg, etc.).

