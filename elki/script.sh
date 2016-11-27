#!/bin/bash
INDIR=/home/enrique/RM/project/Data/reducedSet/*
OUTDIR=/home/enrique/RM/project/Data/Results/OPTICSRAW/
for file in $INDIR
do
	echo "Processing $file file.."
	elki KDDCLIApplication \
	-dbc.in $file \
	-algorithm clustering.optics.OPTICSXi \
	-opticsxi.xi 0.33 -optics.minpts 5 \
	-resulthandler ClusteringVectorDumper \
	-clustering.output ""$OUTDIR"RawResults/$(basename "$file")"
done

for file in "$OUTDIR"RawResults/*
do
	echo $file
	cat $file | tr " " "\n" |head -n -2> $OUTDIR$(basename "$file")
done


#KDDCLIApplication -dbc.in "/media/Datos/Dropbox/Master/S3/Research methodology and scientific writing/project/Data/reducedSet/157" -algorithm clustering.optics.OPTICSXi -opticsxi.xi 0.2 -optics.minpts 15 -resulthandler ClusteringVectorDumper -clustering.output "/media/Datos/Dropbox/Master/S3/Research methodology and scientific writing/project/trajectory-clustering-research/elki/optisoutputLarge"
