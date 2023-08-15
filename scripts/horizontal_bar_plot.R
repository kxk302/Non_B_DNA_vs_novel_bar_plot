#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args) < 6) {
  stop("Specify inhibitAlignmentFill, inhibitDensityFill, useSubsetOfSpecies, plotFilenameTemplate, non-B DNA type, and non-B DNA folder", call.=FALSE)
} 

library(svglite)

#inhibitAlignmentFill = T
inhibitAlignmentFill = args[1]

#inhibitDensityFill = T
inhibitDensityFill = args[2]

#useSubsetOfSpecies = T
useSubsetOfSpecies = args[3]

#plotFilenameTemplate = NULL    # indicates that we draw to a window
plotFilenameTemplate = args[4]

# Allowed values: GQ MR STR APR IR DR Z
non_B_DNA_Type = args[5]

non_B_DNA_Folder = args[6]

# path.nonB = gsub("whats_new.20230429A","non_b_dna.20230503C",getwd())
path.nonB = file.path(getwd(), non_B_DNA_Folder)

chromToAlignmentXXX = read.table("data/chrom_to_alignment.dat",header=F,comment.ch="",colClasses=c("character","character"))
chromToAlignment = chromToAlignmentXXX[,2]
names(chromToAlignment) <- chromToAlignmentXXX[,1]
# ↑↑↑ setting names of a vector object allows us to index the vector by names ↑↑↑

chromToDensityXXX = read.table("data/chrom_to_density.dat",header=F,comment.ch="",colClasses=c("character","character"))
chromToDensity = chromToDensityXXX[,2]
names(chromToDensity) <- chromToDensityXXX[,1]
# ↑↑↑ setting names of a vector object allows us to index the vector by names ↑↑↑

lengthsFilename = "data/dip.20221111.lengths"
if (useSubsetOfSpecies) lengthsFilename = "data/subset.lengths"
chromLengths = read.table(lengthsFilename,header=F,colClasses=c("character","integer"))
chromToLength = chromLengths[,2]
names(chromToLength) <- chromLengths[,1]
# ↑↑↑ setting names of a vector object allows us to index the vector by names ↑↑↑
maxLength = max(chromToLength)

chromToPlotLabelXXX = read.table("data/chrom_to_plot_label.dat",header=F,comment.ch="",colClasses=c("character","character"))
chromToPlotLabel = chromToPlotLabelXXX[,2]
names(chromToPlotLabel) <- chromToPlotLabelXXX[,1]
# ↑↑↑ setting names of a vector object allows us to index the vector by names ↑↑↑

plotFilename = NULL
if (!is.null(plotFilenameTemplate))
	plotFilename = plotFilenameTemplate

# width and height set the size of the drawing window
width  = 12
height = 12
turnDeviceOff = F

if (useSubsetOfSpecies) height = height*(8/12)*(57/61) # 57/61 is a fudge factor

# quartz() opens a drawing window; may not work on non-macs
# otherwise we open a svg file to draw to
if (is.null(plotFilename)) {
	quartz(width=width,height=height)
} else {
	print(paste("drawing to",plotFilename))
	svglite(file=plotFilename,width=width,height=height,pointsize=9)
	turnDeviceOff = T
	}

title = paste("")

alignment.border.color = "black"
preExisting.color = "white"
novel.color = "black"
nonB.border.color = "#FFC20A"    # (yellowish)
nonB.background.color = "white"
nonB.absent.color = "#E69F00"    # (orange)
border.thickness = 2
barSeparation = 0.3  # relative spacing between bars of the same pair
horizontal.extra = 0.06  # relative space to allow for chromosome size text

legText        = c("novel sequence",      "pre-existing sequence","non-B high density","non-B absent")
legColor       = c(novel.color,           preExisting.color,      "black",             "white")
legBorderColor = c(alignment.border.color,alignment.border.color,  nonB.border.color,  nonB.border.color)

# build vectors for the barplot command
bars        = rep(NA,2*length(chromToLength))
barSpacing  = rep(NA,2*length(chromToLength))
fillColor   = rep(NA,2*length(chromToLength))
borderColor = rep(NA,2*length(chromToLength))
for (chromIx in 1:length(chromToLength))
	{
	chromName = names(chromToLength)[chromIx]
	bars[2*chromIx-1] = chromToLength[chromIx]
	bars[2*chromIx  ] = chromToLength[chromIx]
	names(bars)[2*chromIx-1] = paste(chromToPlotLabel[chromName], sep="")
        if (non_B_DNA_Type == "all") {
	  names(bars)[2*chromIx  ] = "All non-B DNA Density"
        } else {
	  names(bars)[2*chromIx  ] = paste(non_B_DNA_Type, "non-B DNA Density")
        }
	barSpacing[2*chromIx-1] = 1.0
	barSpacing[2*chromIx  ] = barSeparation
	fillColor[2*chromIx-1] = nonB.background.color
	fillColor[2*chromIx  ] = novel.color
	borderColor[2*chromIx-1] = nonB.border.color
	borderColor[2*chromIx  ] = alignment.border.color
	}

# set up plot in window
# scipen=10 will cause values on axes to be drawn as integers instead of scientific notation
# par(mar=...) determines what portion of the plot window is reserved for margins
# BLTR means bottom left top right
options(scipen=10)
par(mar=c(8,16,6,10)+0.1)    # BLTR

# this call to barplot establishes the coordinate system in the plot area
# and it draws bars, axes, and labels; barPos is a vector that gives the y
# coordinate of the center of each bar
# plot "empty" bars
par(lwd=border.thickness)  # thickens borders
barPos = barplot(rev(bars), horiz=T, space=barSpacing,
                 col=fillColor, border=borderColor, las=2,
                 main=title, axes=FALSE, xlim=c(0, 200000000))
axis(side=3, at=c(0, 50000000, 100000000, 150000000, 200000000), labels=c(0, 50000000, 100000000, 150000000, 200000000))
axis(side=4, at=c(2.5, 5.5, 9, 12, 15.5, 18.5, 22, 25.5, 29, 31.5, 35, 38.5, 42, 45), labels=c("Siamang", "S. Orangutan", "B. Orangutan", "Gorilla", "Human", "Chimpanzee", "Bonobo", "Siamang", "S. Orangutan", "B. Orangutan", "Gorilla", "Human", "Chimpanzee", "Bonobo"), las=2)

# fill alignment bars
for (chromIx in 1:length(chromToLength))
	{
	# flipIx is because R numbers the bars 1..N from the bottom up, and I want
	# them from the top down
	flipIx = length(chromToLength)+1-chromIx
	yPos = barPos[2*flipIx]
	chromLen = chromToLength[chromIx]
	chromName = names(chromToLength)[chromIx]

	chromLenStr = paste(" ",round(chromLen/(1*1000*1000)),"Mbp",sep="")
	text(chromLen,yPos,chromLenStr,adj=c(0,0.5),cex=.8)

	if (chromName %in% c("chm13.chrX","hg002.chrY")) {
		rect(0,yPos-0.5,chromLen,yPos+0.5,col=preExisting.color,border=NA)    # LBRT
		rect(0,yPos-0.5,chromLen,yPos+0.5,col="NA",border=alignment.border.color,lwd=border.thickness)   # LBRT
		next
		}

	if (!chromName %in% names(chromToAlignment))
		next

	# the fill process is slow when you are drawing to a window (as opposed to
	# a file), so it's can be handy to disable it for debugging
	if (inhibitAlignmentFill)
		next

        chromFilename = paste("new_onto_old/",chromToAlignment[chromName],".new_onto_old.winnowmap.covered.dat.gz",sep="")
        coveredIntervals = read.table(chromFilename,header=F,comment.ch="",colClasses=c("character","integer","integer"))

	print(paste("filling ",chromName,", ",nrow(coveredIntervals)," intervals",sep=""))
	for (ix in 1:nrow(coveredIntervals))
		{
		left  = coveredIntervals[ix,2]
		right = coveredIntervals[ix,3]
		rect(left,yPos-0.5,right,yPos+0.5,col=preExisting.color,border=NA)    # LBRT
		}
	rect(0,yPos-0.5,chromLen,yPos+0.5,col="NA",border=alignment.border.color,lwd=border.thickness)       # LBRT
	}

# fill non-B bars
for (chromIx in 1:length(chromToLength))
	{
	flipIx = length(chromToLength)+1-chromIx
	yPos = barPos[2*flipIx-1]
	chromLen = chromToLength[chromIx]
	chromName = names(chromToLength)[chromIx]

	if (!chromName %in% names(chromToDensity))
		{
		rect(0,yPos-0.5,chromLen,yPos+0.5,col=nonB.absent.color,border=NA)   # LBRT
		rect(0,yPos-0.5,chromLen,yPos+0.5,col="NA",border=nonB.border.color,lwd=border.thickness)   # LBRT
		next
		}

        densityFilename = paste(path.nonB,"/data/",chromToDensity[chromName],"_",non_B_DNA_Type,"_density_final.bed",sep="")
	if (!file.exists(densityFilename))
		{
		rect(0,yPos-0.5,chromLen,yPos+0.5,col=nonB.absent.color,border=NA)   # LBRT
		rect(0,yPos-0.5,chromLen,yPos+0.5,col="NA",border=nonB.border.color,lwd=border.thickness)   # LBRT
		next
		}

	if (inhibitDensityFill)
		next

	densityWindows = read.table(densityFilename,header=T,comment.ch="",colClasses=c("character","integer","integer","numeric"))
        maxDensity = max(densityWindows[,4])

	print(paste("filling nonB",chromName,", ",nrow(densityWindows)," intervals",sep=""))
	for (ix in 1:nrow(densityWindows))
		{
		left  = densityWindows$start[ix]
		right = densityWindows$stop[ix]
		density.normalized = densityWindows$count[ix] / maxDensity
		greyValue = 1 - density.normalized
		color = rgb(greyValue,greyValue,greyValue)
		# greyValue = densityWindows$count[ix] / (right-left)  should use this
		rect(left,yPos-0.5,right,yPos+0.5,col=color,border=NA)    # LBRT
		}
	rect(0,yPos-0.5,chromLen,yPos+0.5,col="NA",border=nonB.border.color,lwd=border.thickness)       # LBRT
	}

par(lwd=border.thickness) # thickens borders
legend("bottom",bg="white",cex=1.0,legText,fill=legColor,border=legBorderColor)

# this is necessary to close the file if we are drawing to a file
if (turnDeviceOff) dev.off()

