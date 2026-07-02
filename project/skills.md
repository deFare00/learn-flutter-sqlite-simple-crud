# Skills Matrix

## Student Attendance Management

**Version:** 1.0

---

# 1. Overview

Dokumen ini menjelaskan keterampilan (skills), teknologi, serta praktik terbaik yang digunakan dalam pengembangan **Student Attendance Management**.

Seluruh implementasi project harus mengacu pada daftar skill berikut agar menghasilkan codebase yang konsisten, modern, dan mudah dipelihara.

---

# 2. Core Technologies

| Skill            |     Level    | Status |
| ---------------- | :----------: | :----: |
| Dart             | Intermediate |    ✅   |
| Flutter          | Intermediate |    ✅   |
| Material 3       | Intermediate |    ✅   |
| SQLite (sqflite) | Intermediate |    ✅   |
| OpenStreetMap    | Intermediate |    ✅   |
| QR Scanner       | Intermediate |    ✅   |

---

# 3. Flutter Development

Project menerapkan praktik pengembangan Flutter modern.

* Feature First Architecture
* Modular Project Structure
* Clean Code
* Separation of Concerns
* Material 3
* Global Theme
* Reusable Widgets
* Constants Management
* Repository Pattern
* Local Database

---

# 4. UI Development

Kemampuan yang diterapkan pada sisi antarmuka.

* Responsive Layout
* Material Design 3
* Custom Theme
* Color Scheme
* Typography
* Component-Based UI
* Reusable Widgets
* Consistent Spacing
* Navigation

---

# 5. Local Storage

Penyimpanan data menggunakan SQLite.

Implementasi meliputi:

* Create Database
* Create Table
* CRUD Operation
* Search Data
* Update Data
* Delete Data
* Database Versioning

---

# 6. QR Technology

Fitur QR Code digunakan untuk identifikasi mahasiswa.

Kemampuan yang diterapkan:

* Generate QR Code
* Scan QR Code
* Decode QR
* Open Student Detail
* SQLite Integration

---

# 7. Maps Technology

Fitur peta menggunakan OpenStreetMap.

Kemampuan yang diterapkan:

* Display Map
* Marker
* Pick Location
* Save Coordinate
* Current Location
* Reverse Geocoding *(opsional)*
* Coordinate Storage

---

# 8. Software Architecture

Project menggunakan arsitektur modular.

Skills yang diterapkan:

* Feature First Architecture
* Repository Pattern
* Datasource Layer
* Presentation Layer
* Service Layer
* Shared Components

---

# 9. Clean Code

Seluruh kode mengikuti prinsip berikut.

* Single Responsibility Principle (SRP)
* Separation of Concerns (SoC)
* DRY (Don't Repeat Yourself)
* KISS (Keep It Simple, Stupid)
* Readable Code
* Consistent Naming
* Small Widgets
* Reusable Components

---

# 10. Flutter Best Practices

Standar implementasi project.

* Gunakan `const` jika memungkinkan.
* Hindari hardcoded value.
* Gunakan `Theme.of(context)`.
* Gunakan `AppColors`.
* Gunakan `AppSizes`.
* Gunakan `AppStrings`.
* Maksimalkan penggunaan `StatelessWidget`.
* Pisahkan business logic dari UI.
* Simpan reusable widget di `shared/widgets`.

---

# 11. Folder Organization

Struktur project mengikuti Feature First.

```text
lib/
├── core/
├── features/
├── shared/
└── main.dart
```

Setiap fitur memiliki struktur yang konsisten sehingga mudah dikembangkan.

---

# 12. Packages

Package utama yang digunakan dalam project.

| Package            | Fungsi               |
| ------------------ | -------------------- |
| flutter            | Framework UI         |
| sqflite            | SQLite Database      |
| path               | Database Path        |
| flutter_map        | Maps                 |
| latlong2           | Latitude & Longitude |
| mobile_scanner     | QR Scanner           |
| qr_flutter         | Generate QR Code     |
| geolocator         | Current Location     |
| permission_handler | Runtime Permission   |

---

# 13. Soft Skills

Pengembangan project juga menerapkan kemampuan non-teknis.

* Problem Solving
* Code Refactoring
* Documentation
* Project Planning
* Feature Planning
* Version Control (Git)
* Modular Thinking
* Debugging

---

# 14. Future Skills

Kemampuan yang akan ditambahkan pada tahap berikutnya.

* REST API Integration
* Firebase
* Authentication
* Riverpod / Provider
* Bloc
* Offline Synchronization
* Push Notification
* Unit Testing
* Widget Testing
* CI/CD
* Deployment

---

# 15. Project Outcome

Setelah project selesai, kemampuan yang telah dipraktikkan meliputi:

* Membangun aplikasi Flutter dengan struktur modular.
* Mengimplementasikan CRUD menggunakan SQLite.
* Menggunakan Feature First Architecture.
* Membuat reusable widgets.
* Mengelola Global Theme dan Constants.
* Mengintegrasikan QR Code dan QR Scanner.
* Mengintegrasikan Maps dan penyimpanan koordinat.
* Menulis kode yang bersih, konsisten, dan mudah dipelihara.
* Mengembangkan project yang siap dijadikan portofolio profesional maupun dasar untuk pengembangan aplikasi yang lebih kompleks.
