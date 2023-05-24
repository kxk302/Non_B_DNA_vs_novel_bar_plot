Files used:

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

results/<alignment_name>.new_onto_old.winnowmap.covered.dat.gz
	- these are the aligned-intervals files; they are three-column files
	  with each line being <chromosome_name> <start> <end>, where the interval
	  is origin-zero half-open; there should not be any overlapping intervals

some_path/data/<density_name>_density_final.bed
	- these are the four column windowed density files
	- this has a header line: chr start stop count
	- on my machine, the location of these files is semi-hard-wired by the
	  statment that sets path.nonB

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

