# Product Requirements Document (PRD)

# Student Attendance Management

**Version:** 1.0

**Platform:** Flutter (Android)

**Status:** In Development

---

# 1. Product Overview

Student Attendance Management adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengelolaan data mahasiswa secara digital. Aplikasi ini memungkinkan pengguna untuk menyimpan, mengubah, menghapus, dan melihat data mahasiswa, serta dilengkapi dengan fitur QR Code dan Maps untuk meningkatkan efisiensi pengelolaan data.

Project ini dibangun sebagai implementasi pembelajaran Flutter dengan menerapkan standar pengembangan aplikasi profesional, seperti Feature First Architecture, Clean Code, Reusable Widgets, dan Modular Project Structure.

---

# 2. Problem Statement

Pengelolaan data mahasiswa secara manual sering kali menimbulkan beberapa permasalahan, seperti:

* Data sulit dikelola ketika jumlah mahasiswa bertambah.
* Sulit menemukan data mahasiswa tertentu dengan cepat.
* Tidak tersedia identifikasi digital menggunakan QR Code.
* Tidak tersedia informasi lokasi mahasiswa.
* Struktur aplikasi sulit dikembangkan jika fitur baru ditambahkan.

Aplikasi ini bertujuan untuk mengatasi permasalahan tersebut dengan menyediakan sistem pengelolaan data yang sederhana, modern, dan mudah dikembangkan.

---

# 3. Product Goals

Project ini memiliki tujuan sebagai berikut:

* Membangun aplikasi Flutter dengan arsitektur yang bersih dan modular.
* Mengimplementasikan CRUD menggunakan SQLite.
* Mengintegrasikan QR Code dan QR Scanner.
* Mengintegrasikan Maps untuk penyimpanan lokasi mahasiswa.
* Menjadi project portofolio yang mencerminkan praktik pengembangan aplikasi profesional.
* Menjadi fondasi yang siap dikembangkan ke REST API maupun Firebase.

---

# 4. Target Users

Aplikasi ditujukan untuk:

* Mahasiswa yang ingin mempelajari Flutter.
* Mobile Developer yang ingin mempelajari Feature First Architecture.
* Recruiter atau interviewer sebagai bahan evaluasi portofolio.
* Tim pengembang yang membutuhkan template project Flutter yang scalable.

---

# 5. Project Scope

## In Scope

### Student Management

* Menampilkan daftar mahasiswa.
* Menambahkan mahasiswa.
* Mengubah data mahasiswa.
* Menghapus mahasiswa.
* Melihat detail mahasiswa.
* Mencari mahasiswa berdasarkan nama.
* Mengurutkan data mahasiswa.

---

### QR Code

* Generate QR Code.
* Menyimpan QR Code pada data mahasiswa.
* Menampilkan QR Code pada halaman detail.

---

### QR Scanner

* Memindai QR Code.
* Mencari data mahasiswa berdasarkan QR Code.
* Membuka halaman detail mahasiswa.

---

### Maps

* Menampilkan peta.
* Memilih lokasi mahasiswa.
* Menyimpan koordinat lokasi.
* Menampilkan marker lokasi mahasiswa.

---

### UI

* Material Design 3.
* Responsive Layout.
* Global Theme.
* Reusable Widgets.
* Empty State.
* Loading State.
* Confirmation Dialog.

---

### Local Database

* SQLite.
* Local Storage.
* Offline First.

---

# 6. Out of Scope

Fitur berikut tidak termasuk dalam versi pertama aplikasi:

* Login & Register.
* Multi-user.
* Sinkronisasi cloud.
* REST API.
* Firebase.
* Push Notification.
* Export PDF.
* Export Excel.
* Presensi otomatis.
* Face Recognition.

Fitur-fitur tersebut akan menjadi bagian dari roadmap pengembangan berikutnya.

---

# 7. Functional Requirements

## Student

* User dapat melihat seluruh data mahasiswa.
* User dapat menambahkan mahasiswa baru.
* User dapat mengubah data mahasiswa.
* User dapat menghapus mahasiswa.
* User dapat melihat detail mahasiswa.

---

## QR

* Sistem menghasilkan QR Code unik untuk setiap mahasiswa.
* Sistem dapat membaca QR Code.
* Sistem menampilkan data mahasiswa berdasarkan hasil scan.

---

## Maps

* User dapat memilih lokasi mahasiswa.
* Sistem menyimpan latitude dan longitude.
* Sistem menampilkan marker pada lokasi yang dipilih.

---

## Database

* Sistem menyimpan seluruh data secara lokal menggunakan SQLite.
* Data tetap tersedia meskipun aplikasi ditutup.

---

# 8. Non-Functional Requirements

## Performance

* Waktu membuka halaman kurang dari 2 detik.
* CRUD berjalan tanpa lag yang signifikan.
* QR Scanner merespons dengan cepat.
* Navigasi antar halaman berjalan lancar.

---

## Maintainability

* Menggunakan Feature First Architecture.
* Menggunakan Clean Code.
* Menggunakan Reusable Widgets.
* Menggunakan Constants.
* Menggunakan Global Theme.

---

## Scalability

Struktur project harus mendukung penambahan:

* REST API.
* Firebase.
* Authentication.
* State Management.
* Unit Testing.

Tanpa perlu mengubah struktur utama project.

---

# 9. User Flow

## Menambah Mahasiswa

```text
Dashboard
      │
      ▼
Student List
      │
      ▼
Add Student
      │
      ▼
Input Data
      │
      ▼
Pick Location
      │
      ▼
Save
      │
      ▼
Student List
```

---

## Scan QR

```text
Dashboard
      │
      ▼
QR Scanner
      │
      ▼
Scan QR
      │
      ▼
Student Detail
```

---

## View Location

```text
Student Detail
      │
      ▼
Open Map
      │
      ▼
View Marker
```

---

# 10. Technology Stack

## Framework

* Flutter
* Dart

## Database

* SQLite
* sqflite

## Maps

* flutter_map
* OpenStreetMap
* latlong2

## QR

* mobile_scanner
* qr_flutter

## Utilities

* geolocator
* permission_handler
* path

---

# 11. Success Metrics

Project dinyatakan berhasil apabila:

* Seluruh fitur CRUD berjalan dengan baik.
* QR Code berhasil dibuat dan dipindai.
* Lokasi mahasiswa berhasil disimpan dan ditampilkan.
* Struktur project mengikuti Feature First Architecture.
* Kode mengikuti standar Clean Code.
* Dokumentasi project lengkap.
* Project layak dijadikan portofolio profesional.

---

# 12. Design Principles

Seluruh tampilan aplikasi harus mengikuti prinsip berikut:

* Clean UI.
* Modern.
* Minimalist.
* Material Design 3.
* Konsisten pada seluruh halaman.
* Responsive.
* Mudah digunakan.

---

# 13. Development Principles

Seluruh implementasi project wajib mengikuti aturan berikut:

* Feature First Architecture.
* Separation of Concerns.
* Single Responsibility Principle (SRP).
* Repository Pattern.
* Reusable Widgets.
* Global Theme.
* Constants Management.
* Naming Convention.
* StatelessWidget jika memungkinkan.
* Gunakan `const` jika memungkinkan.
* Hindari hardcoded value.
* Maksimalkan penggunaan komponen reusable.

---

# 14. Deliverables

Project akan menghasilkan:

* Aplikasi Flutter berbasis SQLite.
* Student CRUD.
* QR Code Generator.
* QR Scanner.
* Maps Integration.
* Global Theme.
* Reusable Widgets.
* Feature First Architecture.
* Dokumentasi lengkap.
* Repository GitHub yang siap dijadikan portofolio.

---

# 15. Future Development

Versi berikutnya akan mencakup:

* Authentication.
* Attendance Management.
* REST API Integration.
* Firebase Integration.
* Push Notification.
* Offline Synchronization.
* Dashboard Analytics.
* Export PDF & Excel.
* Unit & Widget Testing.
* CI/CD Pipeline.

---

# 16. Definition of Done

Sebuah fitur dianggap selesai apabila memenuhi seluruh kriteria berikut:

* Fungsionalitas berjalan sesuai kebutuhan.
* Mengikuti Feature First Architecture.
* Mengikuti standar Clean Code.
* Menggunakan Global Theme.
* Tidak terdapat hardcoded value.
* Menggunakan reusable widget jika memungkinkan.
* Memiliki struktur folder yang konsisten.
* Tidak menghasilkan warning atau error saat dianalisis (`flutter analyze`).
* Dapat dijalankan dan diuji tanpa mengganggu fitur lain.
* Terdokumentasi dengan baik dan siap dipublikasikan ke GitHub.
