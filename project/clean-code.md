# Clean Code Guidelines

# Student Attendance Management

**Version:** 1.0

---

# 1. Purpose

Dokumen ini berisi standar penulisan kode yang digunakan pada seluruh project.

Tujuannya adalah menghasilkan codebase yang:

* Bersih
* Konsisten
* Mudah dibaca
* Mudah dipelihara
* Mudah dikembangkan
* Mudah direview

Seluruh implementasi wajib mengikuti aturan pada dokumen ini.

---

# 2. General Principles

Selalu terapkan prinsip berikut.

* Keep It Simple (KISS)
* Don't Repeat Yourself (DRY)
* Single Responsibility Principle (SRP)
* Separation of Concerns (SoC)
* Readability First
* Composition over Complexity

Kode harus mudah dipahami oleh developer lain tanpa memerlukan penjelasan tambahan.

---

# 3. File Rules

Setiap file hanya memiliki satu tanggung jawab.

Contoh:

✅

```text
student_card.dart
```

Hanya berisi widget StudentCard.

❌

```text
student_card.dart
```

Berisi StudentCard, Dialog, Database, dan Validator sekaligus.

---

# 4. Widget Rules

Gunakan widget kecil.

Target:

* Widget ≤ 150 baris.
* Page ≤ 300 baris.

Jika widget mulai sulit dibaca, pecah menjadi widget baru.

---

# 5. Stateless First

Selalu gunakan:

```dart
StatelessWidget
```

Gunakan `StatefulWidget` hanya jika benar-benar membutuhkan state lokal.

Untuk state yang lebih kompleks, gunakan state management yang sesuai (akan ditambahkan pada fase berikutnya).

---

# 6. Constructor Rules

Gunakan constructor sederhana.

```dart
const StudentCard({
  super.key,
  required this.student,
});
```

Gunakan `required` untuk parameter wajib.

---

# 7. Const Everywhere

Gunakan `const` jika memungkinkan.

✅

```dart
const SizedBox(height: 16)
```

❌

```dart
SizedBox(height: 16)
```

---

# 8. Hardcoded Values

Dilarang menggunakan hardcoded value yang digunakan berulang.

Contoh yang tidak diperbolehkan:

```dart
Colors.blue

Color(0xFF1078CA)

16

24

"Save"
```

Gunakan:

* AppColors
* AppSizes
* AppStrings

---

# 9. Theme Usage

Seluruh style harus berasal dari Global Theme.

Gunakan:

```dart
Theme.of(context)
```

Jangan membuat `TextStyle` baru jika sudah tersedia di `ThemeData`.

---

# 10. Widget Composition

Lebih baik memiliki banyak widget kecil daripada satu widget besar.

Contoh:

```
StudentPage
    │
    ├── StudentHeader
    ├── StudentSearchBar
    ├── StudentList
    └── FloatingButton
```

---

# 11. Business Logic

Business Logic tidak boleh berada di UI.

❌

Page

* SQL
* Validation
* Database
* Repository

✅

Page

↓

Service

↓

Repository

↓

Datasource

↓

SQLite

---

# 12. Method Rules

Method harus melakukan satu pekerjaan.

Contoh yang baik:

```
loadStudents()

saveStudent()

deleteStudent()
```

Hindari method yang melakukan banyak proses sekaligus.

---

# 13. Method Length

Target:

* ≤ 30 baris.

Jika lebih panjang, pecah menjadi beberapa method.

---

# 14. Variable Naming

Gunakan nama yang deskriptif.

✅

```
studentName

currentLocation

isLoading
```

❌

```
a

b

temp

data1
```

---

# 15. Import Order

Urutan import.

```dart
Flutter SDK

↓

Third Party Package

↓

Core

↓

Shared

↓

Feature
```

Contoh:

```dart
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import '../../../core/constants/app_colors.dart';

import '../../../shared/widgets/primary_button.dart';

import '../data/models/student_model.dart';
```

---

# 16. Folder Responsibility

Gunakan folder sesuai tanggung jawab.

| Folder   | Responsibility       |
| -------- | -------------------- |
| core     | Global Configuration |
| shared   | Shared Component     |
| features | Business Feature     |

---

# 17. Reusable Widgets

Jika widget digunakan oleh dua atau lebih fitur, pindahkan ke:

```
shared/widgets
```

Jika hanya digunakan oleh satu fitur:

```
presentation/widgets
```

---

# 18. Error Handling

Selalu tangani kemungkinan error.

Gunakan:

* try-catch
* validasi input
* pesan error yang jelas

Hindari aplikasi berhenti karena exception yang tidak ditangani.

---

# 19. Comments

Komentar hanya digunakan jika benar-benar diperlukan.

Hindari komentar yang menjelaskan sesuatu yang sudah jelas dari nama variabel atau method.

Gunakan nama method dan variabel yang deskriptif sebagai pengganti komentar.

---

# 20. Formatting

Gunakan formatter bawaan Dart.

Selalu jalankan:

```bash
dart format .
```

Sebelum commit.

---

# 21. Static Analysis

Sebelum fitur dianggap selesai, pastikan:

```bash
flutter analyze
```

Tidak menghasilkan:

* Error
* Warning

---

# 22. Performance Rules

* Gunakan `const`.
* Hindari rebuild yang tidak perlu.
* Gunakan `ListView.builder()` untuk data dinamis.
* Hindari widget yang terlalu dalam (deep widget tree).
* Jangan memuat data berulang tanpa kebutuhan.

---

# 23. Code Review Checklist

Sebelum sebuah file dianggap selesai, pastikan:

* Mengikuti Feature First Architecture.
* Mengikuti Naming Convention.
* Menggunakan Global Theme.
* Menggunakan Constants.
* Tidak ada hardcoded value.
* Tidak ada duplicate code.
* Tidak ada business logic di UI.
* Menggunakan reusable widget bila memungkinkan.
* Menggunakan `const` jika memungkinkan.
* Mudah dibaca.
* Mudah dipelihara.
* Berhasil melewati `dart format`.
* Berhasil melewati `flutter analyze`.

---

# 24. Definition of Done

Sebuah implementasi dianggap selesai apabila:

* Fitur berjalan sesuai kebutuhan.
* Struktur folder sesuai standar.
* Kode mengikuti seluruh aturan pada dokumen ini.
* Tidak ada warning maupun error.
* Siap untuk dilakukan code review.
* Siap dikembangkan pada iterasi berikutnya.

---

# 25. AI Coding Rules

Seluruh kode yang dihasilkan AI untuk project ini wajib mengikuti aturan berikut:

* Menggunakan Feature First Architecture.
* Menggunakan Material Design 3.
* Menggunakan Global Theme.
* Menggunakan AppColors, AppSizes, dan AppStrings.
* Menggunakan reusable widget jika memungkinkan.
* Tidak membuat file di luar struktur project.
* Tidak menulis business logic di layer Presentation.
* Mengirimkan file secara lengkap (full code).
* Mengutamakan keterbacaan daripada kode yang terlalu kompleks.
* Menjaga setiap file tetap ringkas dan fokus pada satu tanggung jawab.
* Selalu menghasilkan kode yang siap dijalankan tanpa memerlukan refactoring tambahan.

---

# 26. Project Philosophy

Project ini dibangun bukan hanya untuk menghasilkan aplikasi yang berjalan, tetapi untuk membangun **codebase Flutter yang profesional, modular, scalable, dan mudah dipelihara**.

Setiap keputusan implementasi harus mempertimbangkan keterbacaan, konsistensi, dan kemudahan pengembangan jangka panjang, sehingga project ini dapat menjadi portofolio yang mencerminkan praktik pengembangan perangkat lunak di lingkungan profesional.
