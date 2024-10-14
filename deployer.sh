#!/bin/bash

current_dir=$(pwd)

# list *.yaml,*.yml on current directory
function file_list {
	echo "========================"
	echo "    Choose File:"
	mapfile -t files < <(find "$current_dir" -type f \( -name "*.yaml" -o -name "*.yml" \))

	for i in "${!files[@]}"; do
		echo "$((i + 1))) ${files[i]}"
	done
	echo "========================"
	echo "0) Exit"
}


file_list
read -p "Choose (0-${#files[@]}): " choice

if [[ $choice -eq 0 ]]; then
	echo "Exit"
	exit 0
elif [[ $choice -ge 1 && $choice -le ${#files[@]} ]]; then
	selected_file=${files[$((choice - 1))]}
	# Mengambil hasil grep ke dalam array
	mapfile -t image_list < <(grep -E 'image:.*:.*' "$selected_file")

	# image list menu
	for index in "${!image_list[@]}"; do
		trim_menu=$(echo "${image_list[$index]}" | awk '{$1=$1; print}')
		echo "$index) $trim_menu"
	done

	read -p "Choose image (0-${#image_list[@]})" image_choose
	read -p "Input new tag image: " tag

	# parse image 
	selected_image=${image_list[$image_choose]}
	base_image=$(echo "$selected_image" | cut -d ':' -f 1-2)

	if [ -z $tag ]; then
		echo "tag not input"
		exit 1
	else
		sed -i "s|$base_image:.*|$base_image:$tag|" $selected_file
	fi

	if [ $? -eq 0 ];then
		echo "$selected_image has update tag to $tag"
		exit 0
	else
		echo "failed update tag on file $selected_file"
	fi
else
	echo "option not valid"
fi


