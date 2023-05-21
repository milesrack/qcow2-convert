#!/bin/bash
function usage(){
	echo "Usage: $0 <disk_image>"
	exit
}
[[ $# -eq 0 ]] && usage
temp_dir=$(mktemp -d)
[[ $1 == http* ]] && wget -q $1 -P $temp_dir || cp $1 $temp_dir
disk_image=$(find $temp_dir -type f)
while [[ $disk_image != *.vmdk ]]
do
	if [[ $disk_image == *.ova ]]
	then
		tar -xf $disk_image -C $temp_dir
		disk_image=$(find $temp_dir -type f -name *.vmdk)
	elif [[ $disk_image == *.zip ]]
	then
		unzip $disk_image -d $temp_dir
		disk_image=$(find $temp_dir -type f -name *.vmdk -o -name *.ova)
	elif [[ $disk_image == *.7z ]]
	then
		7z x $disk_image -o$temp_dir
		disk_image=$(find $temp_dir -type f -name *.vmdk -o -name *.ova)
	fi
done
qcow2_image=$(echo $disk_image | sed 's/.vmdk/.qcow2/')
qemu-img convert -f vmdk -O qcow2 "$disk_image" "$qcow2_image"
echo "$qcow2_image"
