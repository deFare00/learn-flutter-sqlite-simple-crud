# Database Design

## Student Attendance Management

**Database:** SQLite

---

# 1. Overview

Project ini menggunakan **SQLite** sebagai database lokal untuk menyimpan seluruh data aplikasi.

Desain database dibuat sederhana, terstruktur, dan mudah dikembangkan apabila di kemudian hari project menggunakan REST API atau Firebase.

---

# 2. Database Information

| Item             | Value             |
| ---------------- | ----------------- |
| Database         | student.db        |
| Database Version | 1                 |
| Database Engine  | SQLite            |
| ORM              | sqflite           |
| Migration        | Manual Versioning |

---

# 3. Entity Relationship

Saat ini project memiliki satu entitas utama.

```text
Student
```

Diagram sederhana:

```text
Student
│
├── id
├── name
├── age
├── major
├── phone
├── email
├── qr_code
├── latitude
├── longitude
├── address
├── created_at
└── updated_at
```

Database dirancang agar mudah ditambahkan tabel baru seperti:

* Attendance
* User
* Settings
* History

---

# 4. Student Table

**Table Name**

```text
students
```

| Column     | Type    | Constraint                | Description                               |
| ---------- | ------- | ------------------------- | ----------------------------------------- |
| id         | INTEGER | PRIMARY KEY AUTOINCREMENT | ID mahasiswa                              |
| name       | TEXT    | NOT NULL                  | Nama mahasiswa                            |
| age        | INTEGER | NOT NULL                  | Umur                                      |
| major      | TEXT    | NOT NULL                  | Jurusan                                   |
| phone      | TEXT    | NULL                      | Nomor telepon                             |
| email      | TEXT    | NULL                      | Email                                     |
| qr_code    | TEXT    | UNIQUE                    | QR Code mahasiswa                         |
| latitude   | REAL    | NULL                      | Latitude lokasi                           |
| longitude  | REAL    | NULL                      | Longitude lokasi                          |
| address    | TEXT    | NULL                      | Alamat hasil reverse geocoding (opsional) |
| created_at | TEXT    | NOT NULL                  | Tanggal dibuat                            |
| updated_at | TEXT    | NULL                      | Tanggal terakhir diperbarui               |

---

# 5. SQL Schema

```sql
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    major TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    qr_code TEXT UNIQUE,
    latitude REAL,
    longitude REAL,
    address TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT
);
```

---

# 6. Data Model

Setiap mahasiswa memiliki informasi berikut.

```text
Student

ID

Name

Age

Major

Phone

Email

QR Code

Latitude

Longitude

Address

Created At

Updated At
```

---

# 7. QR Code

Setiap mahasiswa memiliki **QR Code** yang bersifat unik.

Contoh:

```text
STUDENT-000001
```

atau

```text
STD_1
```

QR Code digunakan untuk:

* Scan mahasiswa
* Membuka detail mahasiswa
* Presensi (pengembangan berikutnya)

---

# 8. Maps Data

Lokasi mahasiswa disimpan menggunakan koordinat.

| Data      | Type |
| --------- | ---- |
| Latitude  | REAL |
| Longitude | REAL |

Contoh:

```text
Latitude

-6.402484
```

```text
Longitude

106.794241
```

Koordinat akan diperoleh dari halaman pemilihan lokasi menggunakan Maps.

---

# 9. CRUD Operations

Database mendukung operasi berikut.

### Create

Menambahkan mahasiswa baru.

---

### Read

Mengambil seluruh data mahasiswa.

Mengambil detail mahasiswa berdasarkan ID.

---

### Update

Mengubah data mahasiswa.

---

### Delete

Menghapus mahasiswa.

---

# 10. Search & Filter

Database dirancang agar mudah mendukung fitur berikut.

* Search berdasarkan nama
* Search berdasarkan jurusan
* Sort berdasarkan nama
* Sort berdasarkan tanggal
* Filter berdasarkan jurusan

---

# 11. Future Tables

Ke depannya database dapat diperluas.

## Attendance

```text
attendance

id

student_id

scan_time

latitude

longitude

status
```

---

## User

```text
users

id

name

email

password
```

---

## Settings

```text
settings

id

theme

language
```

---

# 12. Naming Convention

Gunakan aturan berikut.

| Item   | Convention      |
| ------ | --------------- |
| Table  | snake_case      |
| Column | snake_case      |
| Model  | PascalCase      |
| File   | snake_case.dart |

Contoh:

```text
students
```

```text
student_model.dart
```

---

# 13. Database Rules

* Gunakan Primary Key Auto Increment.
* Gunakan nama tabel dalam bentuk jamak (`students`).
* Gunakan snake_case untuk nama kolom.
* Hindari menyimpan data yang sama lebih dari satu kali.
* Gunakan tipe data yang sesuai (`INTEGER`, `TEXT`, `REAL`).
* Simpan tanggal dalam format ISO-8601 (`DateTime.now().toIso8601String()`).

---

# 14. Future Migration

Apabila aplikasi berkembang menggunakan REST API atau Firebase, struktur model **Student** tidak perlu diubah.

Hanya implementasi **Datasource** yang akan berubah.

```text
Current

StudentRepository

↓

SQLite Datasource
```

Menjadi

```text
StudentRepository

↓

API Datasource
```

atau

```text
StudentRepository

↓

Firebase Datasource
```

Dengan demikian, layer Presentation dan Repository tetap dapat digunakan tanpa perubahan besar.

---

# 15. Database Goals

Tujuan desain database ini adalah:

* Mudah dipahami.
* Ringan untuk aplikasi lokal.
* Mendukung CRUD Student.
* Mendukung fitur QR Scanner.
* Mendukung fitur Maps.
* Mudah dikembangkan untuk Attendance.
* Siap dimigrasikan ke REST API maupun Firebase di masa mendatang.
