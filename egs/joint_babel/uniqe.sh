#!/bin/bash

#Only merge scripted/training, scripted/reference_materials to conversational/**.

for dir in IARPA_BABEL_BP_101  IARPA_BABEL_BP_105  IARPA_BABEL_OP1_102  IARPA_BABEL_OP3_404 IARPA_BABEL_BP_104  IARPA_BABEL_BP_106  IARPA_BABEL_OP1_103; do
#	sub_dir1=$dir/scripted/training
#	sub_dir2=$dir/conversational/training
#
#	for x in audio transcript_roman transcription; do
#		if [ "`ls -A $sub_dir1/$x`" != "" ]; then
#		for file in $sub_dir1/$x/*; do
#			path=`realpath $file`
#			name=`basename $path`
#			if [ ! -f $sub_dir2/$x/$name ]; then
#				ln -s $path $sub_dir2/$x/$name
#			fi
#		done
#		fi
#	done
#
#	cp $sub_dir2/data.list $sub_dir2/data.list.orig
#	cat $sub_dir1/data.list >> $sub_dir2/data.list
#
#	sub_dir1=$dir/scripted/reference_materials
        sub_dir2=$dir/conversational/reference_materials
	for x in demographics.sub-train.tsv demographics.tsv lexicon.sub-train.txt lexicon.txt; do
#		cp $sub_dir2/$x $sub_dir2/${x}.orig
#		cat $sub_dir1/$x >> $sub_dir2/$x
#		sort -u $sub_dir2/$x > $sub_dir2/${x}.uniq
#		#mv $sub_dir2/${x}.uniq $sub_dir2/$x
#		#keep only one pronunciation for each word
		cat $sub_dir2/${x} | \
		  perl -e 'while(<>){@A = split; if(! $seen{$A[0]}) {$seen{$A[0]} = 1; print $_;}}' \
		  > $sub_dir2/${x}.uniq || exit 1;
		mv $sub_dir2/${x} $sub_dir2/${x}.sort_uniq
		mv $sub_dir2/${x}.uniq $sub_dir2/$x


	done

done

