#!/bin/bash

# URL yang akan diuji
url="https://www.example.com"

# Fungsi untuk mengukur waktu muat
measure_load_time() {
  curl -o /dev/null -s -w "%{time_total}\n" "$1"
}

# Fungsi untuk menampilkan server CDN yang digunakan
identify_cdn() {
  echo "Mengidentifikasi server CDN untuk URL: $1"
  curl -s -I "$1" | grep -i "x-cache\|server"
}

echo "Pengujian CDN untuk URL: $url"

# Pengujian AWS CloudFront
echo "AWS CloudFront:"
load_time_aws=$(measure_load_time "$url")
echo "Waktu muat: $load_time_aws detik"
identify_cdn "$url"

# Pengujian Akamai
echo "Akamai CDN:"
load_time_akamai=$(measure_load_time "$url" -H "Host: www.example.com")
echo "Waktu muat: $load_time_akamai detik"
identify_cdn "$url"

# Pengujian Tencent Cloud CDN
echo "Tencent Cloud CDN:"
load_time_tencent=$(measure_load_time "$url" -H "Host: www.example.com" --resolve "www.example.com:443:cdn.example.com")
echo "Waktu muat: $load_time_tencent detik"
identify_cdn "$url"

