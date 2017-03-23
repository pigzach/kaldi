#!/bin/bash

. ./path.sh
. ./cmd.sh

seg=20

nj=8
dir=net_output
new_dir=lid_eval3_seg${seg}
mkdir -p $new_dir


i=0
for mdl in models/*_1_2_3_4/* ; do
  for id in 1_seg${seg} 2_seg${seg} 3_seg${seg} 4_seg${seg}; do 
    m_base=`basename $mdl`
    echo ">>>>>>>>>>>${m_base}.${id}"

    if [  -f $dir/output.${m_base}.${id}.ark ]; then
      sed '/\[/d' $dir/output.${m_base}.${id}.ark > $new_dir/temp
      sed -i 's/\]//g' $new_dir/temp
      awk -v lang=lang$id '{print lang, $1, $3, $2, $4}' $new_dir/temp >> $new_dir/output.${m_base}.seg${seg}.ark
      rm $new_dir/temp
    fi
    echo "<<<<<<<<<<<<<<<<<<<<<<<<<<${m_base}.${id}"
  done

  sed -i '1s/^/      lang1_seg20    lang2_seg20    lang3_seg20    lang4_seg20\n/' $new_dir/output.${m_base}.seg${seg}.ark
done

wait; 
echo "*************All done**************"

exit 0;

