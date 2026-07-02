# Project Structure

# Student Attendance Management

**Version:** 1.0

---

# 1. Overview

Project ini menggunakan **Feature First Architecture** dengan struktur folder yang modular, scalable, dan mudah dipelihara.

Seluruh source code harus mengikuti struktur ini. Penambahan file atau fitur baru tidak boleh mengubah organisasi folder yang telah ditentukan.

---

# 2. Folder Structure

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
│   ├── dashboard/
│   ├── student/
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

# 3. Core

Folder `core` berisi kode yang digunakan secara global oleh seluruh aplikasi.

```text
core/
│
├── constants/
├── routes/
├── services/
├── theme/
└── utils/
```

---

## constants

Berisi nilai tetap (constants).

Contoh:

```text
app_assets.dart
app_colors.dart
app_sizes.dart
app_strings.dart
```

Digunakan oleh seluruh project.

---

## routes

Berisi konfigurasi navigasi aplikasi.

Contoh:

```text
app_routes.dart
route_generator.dart
```

Seluruh perpindahan halaman dikelola dari folder ini.

---

## services

Berisi service yang digunakan oleh lebih dari satu fitur.

Contoh:

```text
database_service.dart
permission_service.dart
```

Jangan menyimpan service yang hanya digunakan oleh satu fitur di folder ini.

---

## theme

Konfigurasi tampilan global aplikasi.

Contoh:

```text
app_theme.dart
app_text_theme.dart
```

Seluruh halaman harus menggunakan Global Theme.

---

## utils

Berisi helper function.

Contoh:

```text
validator.dart
formatter.dart
extensions.dart
```

---

# 4. Features

Setiap fitur memiliki folder sendiri.

```text
features/
│
├── dashboard/
├── student/
├── qr/
├── maps/
└── settings/
```

Setiap fitur harus bersifat independen.

---

# 5. Feature Structure

Seluruh fitur wajib mengikuti struktur berikut.

```text
feature_name/
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

# 6. Data Layer

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

```text
student_local_datasource.dart
```

---

## models

Berisi model data.

Contoh:

```text
student_model.dart
```

---

## repositories

Menjadi penghubung antara Presentation dan Datasource.

Contoh:

```text
student_repository.dart
```

Repository bertanggung jawab terhadap operasi CRUD dan menjadi satu-satunya pintu masuk data bagi layer di atasnya.

---

# 7. Presentation Layer

```text
presentation/
│
├── pages/
└── widgets/
```

---

## pages

Berisi halaman aplikasi.

Contoh:

```text
student_list_page.dart
add_student_page.dart
student_detail_page.dart
```

Satu file = satu halaman.

---

## widgets

Berisi widget yang hanya digunakan oleh fitur tersebut.

Contoh:

```text
student_card.dart
student_header.dart
student_info_tile.dart
```

Jika widget digunakan oleh banyak fitur, pindahkan ke `shared/widgets`.

---

# 8. Feature Services

```text
services/
```

Berisi business logic yang hanya digunakan oleh fitur tersebut.

Contoh:

```text
student_service.dart
qr_service.dart
```

Jangan menyimpan UI di folder ini.

---

# 9. Shared

```text
shared/
│
└── widgets/
```

Folder ini berisi widget yang digunakan oleh lebih dari satu fitur.

Contoh:

```text
primary_button.dart
secondary_button.dart
app_text_field.dart
loading_widget.dart
empty_state.dart
confirmation_dialog.dart
app_card.dart
```

Rule:

* Digunakan oleh ≥ 2 fitur → `shared/widgets`
* Digunakan oleh 1 fitur → `presentation/widgets`

---

# 10. Main Entry

```text
main.dart
```

Tanggung jawab:

* Menjalankan aplikasi.
* Menginisialisasi database.
* Mengatur Theme.
* Mengatur Route.
* Menjalankan `MaterialApp`.

Hindari menambahkan business logic pada `main.dart`.

---

# 11. File Naming

Gunakan `snake_case`.

Contoh:

```text
student_model.dart
student_repository.dart
student_card.dart
```

Hindari:

```text
Student.dart
Database2.dart
baru.dart
```

---

# 12. Class Naming

Gunakan `PascalCase`.

Contoh:

```text
StudentModel
StudentRepository
StudentCard
PrimaryButton
```

---

# 13. Variable Naming

Gunakan `camelCase`.

Contoh:

```text
studentName
studentAge
currentLocation
isLoading
```

---

# 14. Folder Rules

* Maksimal satu tanggung jawab untuk setiap folder.
* Hindari folder kosong.
* Jangan membuat folder baru tanpa alasan yang jelas.
* Ikuti struktur yang telah ditetapkan.

---

# 15. Widget Rules

* Widget reusable → `shared/widgets`
* Widget khusus fitur → `presentation/widgets`
* Widget kecil dan fokus pada satu tanggung jawab.
* Hindari widget dengan ratusan baris kode.

---

# 16. Data Flow

Seluruh data mengikuti alur berikut.

```text
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

Page tidak boleh mengakses SQLite secara langsung.

---

# 17. Feature Communication

Komunikasi antar fitur dilakukan melalui Repository atau Service.

Contoh:

```text
Dashboard
        │
        ▼
StudentRepository
```

Bukan:

```text
Dashboard
        │
        ▼
StudentLocalDatasource
```

---

# 18. Dependency Rules

Urutan dependency:

```text
Presentation
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

Layer bawah tidak boleh bergantung pada layer di atasnya.

---

# 19. Future Scalability

Struktur ini telah dipersiapkan untuk mendukung:

* REST API
* Firebase
* Authentication
* State Management
* Unit Testing
* Widget Testing
* CI/CD

Tanpa perlu mengubah struktur utama project.

---

# 20. Project Rules

Seluruh source code wajib mengikuti aturan berikut:

* Feature First Architecture.
* Clean Code.
* Separation of Concerns.
* Single Responsibility Principle.
* Repository Pattern.
* Reusable Widgets.
* Global Theme.
* Constants Management.
* Material Design 3.
* Tidak ada hardcoded value.
* Tidak ada business logic di UI.
* Gunakan `const` jika memungkinkan.
* Setiap fitur memiliki struktur folder yang sama.

---

# 21. Definition of Good Structure

Struktur project dianggap baik apabila:

* Mudah dipahami oleh developer baru.
* Mudah menemukan file berdasarkan fitur.
* Mudah menambahkan fitur baru.
* Mudah melakukan refactoring.
* Tidak ada duplikasi kode.
* Seluruh folder memiliki tanggung jawab yang jelas.
* Siap dikembangkan menjadi aplikasi berskala besar.
