To generate the horizontal bar plot, after cloning the repo, perform the following operations:

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

Gorilla_gorilla_chrX_APR_density_final.bed
Gorilla_gorilla_chrY_APR_density_final.bed
Homo_sapiens_chrX_APR_density_final.bed
Homo_sapiens_chrY_APR_density_final.bed
Pan_paniscus_chrX_APR_density_final.bed
Pan_paniscus_chrY_APR_density_final.bed
Pan_troglodytes_chrX_APR_density_final.bed
Pan_troglodytes_chrY_APR_density_final.bed
Pongo_abelii_chrX_APR_density_final.bed
Pongo_abelii_chrY_APR_density_final.bed
Pongo_pygmaeus_chrX_APR_density_final.bed
Pongo_pygmaeus_chrY_APR_density_final.bed
Symphalangus_syndactylus_chrX_APR_density_final.bed
Symphalangus_syndactylus_chrY_APR_density_final.bed

4. The 'data' folder has the following files. Their description is given below.

data/dip.20221111.lengths (OR data/subset.lengths)
	- list of <chromosome_name> <length>, one per line
	- chromosome_name should contain the name of the individual as a prefix,
	  e.g. chm13 or mPanTro3; so for example something like chm13.chrX or
	  mPanTro3.chrY
	- order in this file determines order that bars are plotted

data/chrom_to_alignment.dat
	- list of <chromosome_name> <alignment_name>, one per line
	- this maps from the name of the individual to the base name of the
	  corresponding aligned-intervals file; e.g.
	    mGorGor1.chrX gorGor.chrX
	- if a particular <chromosome_name> doesn't exist in this file, it's
	  aligned-intervals bar is drawn as being all novel sequence
	- chm13.chrX and hg002.chrY are hard-wired special cases for which the
	  aligned-intervals bar is drawn as being all pre-existing sequence

data/chrom_to_density.dat
	- list of <chromosome_name> <density_name>, one per line
	- this maps from the name of the individual to the base name of the
	  corresponding density file; e.g.
	   mGorGor1.chrX Gorilla_gorilla_chrX

# Controls -- choose one or the other of each setting

plotFilenameTemplate = "temp/new_onto_old.pdf"
 --OR--
plotFilenameTemplate = NULL    # indicates that we draw to a window

inhibitAlignmentFill = T
 --OR--
inhibitAlignmentFill = F

inhibitDensityFill = T
 --OR--
inhibitDensityFill = F

useSubsetOfSpecies = T
 --OR--
useSubsetOfSpecies = F

