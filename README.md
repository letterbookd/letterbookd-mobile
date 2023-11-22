# letterbookd 📖

[![Develop](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/develop.yml/badge.svg)](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/develop.yml)
[![Pre-Release](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/pre-release.yml/badge.svg)](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/pre-release.yml)
[![Release](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/release.yml/badge.svg)](https://github.com/letterbookd/letterbookd-mobile/actions/workflows/release.yml)
[![Build status](https://build.appcenter.ms/v0.1/apps/c458ebb8-218a-4fa7-93b2-5d27c6dd9dea/branches/main/badge)](https://appcenter.ms)

Bringing you, your books, and readers together. Now on mobile.

*Tugas Kelompok Proyek Akhir Semester kelompok A09 untuk mata kuliah Pemrograman Berbasis Platform Semester Ganjil 2023/2024.*

## 📦 Aplikasi

📱 File APK dapat diunduh di halaman *[releases](https://github.com/letterbookd/letterbookd-mobile/releases)* repositori atau melalui [Microsoft Visual Studio App Center](https://install.appcenter.ms/orgs/letterbookd/apps/letterbookd/distribution_groups/public).
Untuk saat ini, *letterbookd* hanya tersedia di platform Android.  
🌐 Untuk versi web, kunjungi website kami [disini](https://letterbookd-a09-tk.pbp.cs.ui.ac.id).

## 🧑‍💻 Pengembang Aplikasi

> Wahyu Hidayat - `2206081894`  
> Muhammad Milian Alkindi - `2206081856`  
> Evelyn Paramesti Hotmauli Silalahi `2206031012`  
> Rana Koesumastuti `2206083496`  
> Muhammad Syahrul Khaliq `2206083092`  

## ✍️ Latar Belakang Aplikasi

***letterbookd*** (semua huruf nonkapital) adalah aplikasi yang bertujuan untuk menyatukan pembaca dengan buku dan pembaca buku lainnya.
Dengan menggunakan aplikasi ini, pembaca dapat menyimpan buku dari katalog ke *Library* personal mereka, memberikan ulasan
untuk buku yang sudah dibaca, dan juga melihat ulasan buku oleh pembaca lainnya.
Buku-buku yang ada di dalam *library* personal dapat diatur status *tracking*nya untuk memudahkan pengguna melacak status buku mereka.

## 📋 Daftar Modul

### 🥸 Guest `[developer: semua]`

Memfasilitasi fungsi *sign in*, *sign up* dan *logout* dari aplikasi.

### 📖 Library `[developer: Muhammad Milian Alkindi]`

*Library* personal pembaca.

- `CREATE` Menambahkan buku ke *library* Reader
- `DELETE` Mengeluarkan buku dari *library* Reader
- `UPDATE` Mengubah status *tracking* buku dalam *library*
  - Status Tracking: `FINISHED`, `READING`, `ON HOLD`, `DROPPED`, `UNTRACKED`
- `READ` Menampilkan halaman library sesuai dengan *search*, *sort*, *filter* dan *display*

### 📚 Catalog `[developer: Evelyn Paramesti Hotmauli Silalahi]`

Katalog buku yang ada di aplikasi.

- `CREATE` Menambahkan buku ke katalog **\[LIBRARIAN-ONLY\]**
- `DELETE` Menghapus buku dari katalog **\[LIBRARIAN-ONLY\]**
- `UPDATE` Mengedit data buku yang ada di katalog **\[LIBRARIAN-ONLY\]**
- `READ` Menampilkan buku dalam katalog sesuai dengan *search*, *sort*, *filter*, dan *display*
- `READ` Menampilkan halaman buku tersendiri

### ⭐ Review `[developer: Rana Koesumastuti]`

Review buku oleh pembaca. Rating dari buku berubah setelah data review yang terkait berubah

- `CREATE` Menambahkan review Reader untuk suatu buku
- `DELETE` Menghapus review suatu buku oleh Reader
- `UPDATE` Mengedit review suatu buku oleh Reader
- `READ` Menampilkan semua review untuk suatu buku
  - Review akan ditampilkan di halaman buku tersendiri (cek modul Catalog)

### 💬 Forum `[developer: Muhammad Syahrul Khaliq]`

Forum diskusi untuk para pembaca

- `CREATE` Memulai *thread* baru di forum
- `CREATE` Mengirim *reply* untuk suatu *post*
- `UPDATE` Mengedit *post/reply* milik sendiri
- `DELETE` Menghapus *post* atau *reply* milik sendiri
- `READ` Menampilkan halaman utama forum (urut sesuai reply terakhir)
- `READ` Menampilkan *thread* secara utuh

### 🧑 Reader `[developer: Wahyu Hidayat]`

- `UPDATE` Mengubah display_name dan bio di profile page
- `UPDATE` Halaman settings untuk mengubah yang berkaitan dengan akun Reader
- `READ` Menampilkan halaman profile Reader
- `READ` Menampilkan hasil searching untuk suatu reader
- `READ` Mengembalikan data akun Reader untuk digunakan

## 👤 Peran Pengguna

- `Guest`: Dapat mengakses *sign in* (login) dan *sign up* (register).
- `Reader`: Dapat menambahkan buku dari katalog ke *Library* personal. Buku yang sudah ada bisa diganti status *tracking*nya. Juga dapat memposting ulasan/review buku yang sudah ada di *library*, serta berdiskusi dengan Reader lainnya di forum.
- `Librarian`: Mengelola katalog buku. Dapat menambah, mengedit, dan menghapus buku dari katalog

## 🔗 Alur integrasi dengan *web service* aplikasi web

Berikut adalah langkah-langkah yang akan dilakukan untuk mengintegrasikan aplikasi dengan server web:

1. Mengimplementasikan sebuah wrapper class dengan menggunakan library `http` dan `map` untuk mendukung penggunaan cookie-based authentication pada aplikasi.
2. Mengimplementasikan `REST` API pada Django (`views.py`) dengan menggunakan `JsonResponse` atau Django JSON Serializer.
3. Mengimplementasikan desain front-end untuk aplikasi berdasarkan desain website yang sudah ada sebelumnya.
4. Melakukan integrasi antara front-end dengan back-end dengan menggunakan konsep *asynchronous* HTTP.

## 📝 Notes

[Tautan berita acara 📆](https://docs.google.com/spreadsheets/d/1UNGaPaQ8nQ7zmio4M-HZPhDgXyd9DHPIPtkiBV2v9Vc/view?usp=sharing)
