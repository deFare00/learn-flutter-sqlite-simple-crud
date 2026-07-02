# Architecture

## Student Attendance Management

**Version:** 1.0

---

# 1. Overview

Project ini menggunakan pendekatan **Feature First Architecture** dengan prinsip **Separation of Concerns** dan **Clean Code**.

Setiap fitur memiliki folder sendiri sehingga mudah dikembangkan, diuji, dan dipelihara tanpa memengaruhi fitur lain.

Arsitektur ini dirancang agar mudah dikembangkan dari aplikasi lokal berbasis SQLite menjadi aplikasi berbasis REST API maupun Firebase tanpa mengubah struktur utama project.

---

# 2. Architecture Principles

Project ini menerapkan prinsip berikut:

* Feature First Architecture
* Separation of Concerns (SoC)
* Single Responsibility Principle (SRP)
* Reusable Components
* Global Theme
* Constants Management
* Clean Code
* Modular Development
* Scalable Folder Structure

---

# 3. High-Level Architecture

```text
Presentation Layer
        │
        ▼
Business / Service Layer
        │
        ▼
Repository Layer
        │
        ▼
Datasource Layer
        │
        ▼
SQLite Database
```

Setiap layer hanya berkomunikasi dengan layer di bawahnya.

---

# 4. Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── routes/
│   ├── services/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── student/
│   ├── dashboard/
│   ├── qr/
│   ├── maps/
│   └── settings/
│
├── shared/
│   └── widgets/
│
└── main.dart
```

---

# 5. Core Layer

Folder `core` berisi komponen global yang digunakan oleh seluruh aplikasi.

```text
core/
│
├── constants/
├── routes/
├── services/
├── theme/
└── utils/
```

## constants

Berisi seluruh nilai tetap.

Contoh:

* AppColors
* AppSizes
* AppStrings
* AppAssets

---

## theme

Berisi konfigurasi tema aplikasi.

Contoh:

* AppTheme
* ColorScheme
* TextTheme

---

## routes

Mengelola seluruh navigasi aplikasi.

Contoh:

* AppRoutes
* RouteGenerator

---

## services

Berisi service global.

Contoh:

* DatabaseService
* PermissionService

---

## utils

Berisi helper.

Contoh:

* Validator
* Formatter
* Extensions

---

# 6. Feature Layer

Seluruh fitur aplikasi berada di dalam folder `features`.

Setiap fitur bersifat independen.

Contoh:

```text
features/
│
├── student/
├── qr/
├── maps/
├── dashboard/
└── settings/
```

---

# 7. Feature Structure

Setiap fitur memiliki struktur yang sama.

```text
student/
│
├── data/
│   ├── datasource/
│   ├── models/
│   └── repositories/
│
├── presentation/
│   ├── pages/
│   └── widgets/
│
└── services/
```

---

# 8. Data Layer

Data Layer bertanggung jawab mengambil dan menyimpan data.

```text
data/
│
├── datasource/
├── models/
└── repositories/
```

## datasource

Berkomunikasi langsung dengan SQLite.

Contoh:

* StudentLocalDatasource

---

## models

Representasi object.

Contoh:

* StudentModel

---

## repositories

Menjadi penghubung antara Presentation dan Datasource.

Contoh:

* StudentRepository

---

# 9. Presentation Layer

Presentation hanya bertanggung jawab menampilkan UI.

```text
presentation/
│
├── pages/
└── widgets/
```

## pages

Halaman aplikasi.

Contoh:

* StudentListPage
* AddStudentPage
* StudentDetailPage

---

## widgets

Widget yang hanya digunakan oleh fitur Student.

Contoh:

* StudentCard
* StudentHeader
* StudentInfoTile

---

# 10. Shared Layer

Folder `shared` berisi komponen yang digunakan oleh banyak fitur.

```text
shared/
│
└── widgets/
```

Contoh:

* PrimaryButton
* AppTextField
* LoadingWidget
* EmptyState
* AppDialog
* AppCard

Jika sebuah widget digunakan oleh lebih dari satu fitur, letakkan di folder `shared`.

---

# 11. Data Flow

Seluruh data mengikuti alur berikut.

```text
User Interaction
        │
        ▼
Page
        │
        ▼
Service
        │
        ▼
Repository
        │
        ▼
Datasource
        │
        ▼
SQLite
```

Contoh saat menambahkan mahasiswa:

```text
AddStudentPage
        │
        ▼
StudentService
        │
        ▼
StudentRepository
        │
        ▼
StudentLocalDatasource
        │
        ▼
SQLite
```

---

# 12. Feature Communication

Setiap fitur tidak boleh mengakses data fitur lain secara langsung.

Contoh yang benar:

```text
Dashboard
      │
      ▼
StudentRepository
```

Contoh yang tidak diperbolehkan:

```text
Dashboard Page
      │
      ▼
SQLite
```

Semua akses data harus melalui Repository.

---

# 13. Dependency Rules

Dependency hanya boleh mengalir ke bawah.

```text
Presentation
    ↓
Service
    ↓
Repository
    ↓
Datasource
    ↓
Database
```

Layer bawah tidak boleh mengetahui layer di atasnya.

---

# 14. Naming Convention

Gunakan suffix berikut.

| Komponen   | Contoh                          |
| ---------- | ------------------------------- |
| Page       | `student_list_page.dart`        |
| Widget     | `student_card.dart`             |
| Model      | `student_model.dart`            |
| Repository | `student_repository.dart`       |
| Datasource | `student_local_datasource.dart` |
| Service    | `student_service.dart`          |

---

# 15. Clean Code Rules

* Satu file memiliki satu tanggung jawab.
* Hindari business logic di UI.
* Gunakan `const` jika memungkinkan.
* Hindari hardcoded value.
* Gunakan AppTheme.
* Gunakan AppColors.
* Gunakan AppSizes.
* Gunakan reusable widget.
* Maksimalkan penggunaan StatelessWidget.
* Simpan widget yang digunakan banyak fitur di `shared/widgets`.
* Simpan widget khusus fitur di `presentation/widgets`.

---

# 16. Scalability

Arsitektur ini dirancang agar mudah dikembangkan.

Tahap berikutnya dapat ditambahkan tanpa mengubah struktur utama.

* Authentication
* REST API
* Firebase
* Offline Sync
* Push Notification
* State Management (Provider / Riverpod / Bloc)
* Unit Test
* Integration Test

---

# 17. Architecture Goals

Tujuan utama arsitektur ini adalah:

* Mudah dipahami.
* Mudah dipelihara.
* Mudah dikembangkan.
* Mengurangi duplikasi kode.
* Memisahkan tanggung jawab setiap layer.
* Mendukung pengembangan fitur baru tanpa mengganggu fitur yang sudah ada.
* Menghasilkan codebase yang bersih, modular, dan siap digunakan pada proyek berskala kecil hingga menengah.
