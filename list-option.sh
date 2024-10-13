#!/bin/bash

# Fungsi untuk menampilkan menu dengan file di direktori saat ini
function display_menu {
	echo "========================"
	echo "    Pilih File:"
	# Menampilkan semua file di direktori saat ini
	files=(*)
	for i in "${!files[@]}"; do
		echo "$((i + 1))) ${files[i]}"
	done
	echo "========================"
	echo "0) Keluar"
}

# Loop untuk menampilkan menu dan meminta input pengguna
while true; do
	display_menu
	read -p "Masukkan pilihan (0-${#files[@]}): " choice

	if [[ $choice -eq 0 ]]; then
		echo "Keluar dari program."
		exit 0
	elif [[ $choice -ge 1 && $choice -le ${#files[@]} ]]; then
		selected_file=${files[$((choice - 1))]}
		echo "Anda memilih file: $selected_file"
		# Di sini, kamu bisa menambahkan logika tambahan untuk memproses file yang dipilih
	else
		echo "Pilihan tidak valid, silakan coba lagi."
	fi
done

# sed -i.bak 's/\(image:.*:\).*/\1staging/g' "$compose_file"
#
#grep -E 'image:.*:.*' docker-compose.yml
#
#  # Contoh string
# image="image: registry/project/app:latest"
#
# # Mengambil bagian sebelum terakhir `:`
# base_image=$(echo "$image" | cut -d ':' -f 1-2)
#
# # Hasil
# echo "$base_image:"
