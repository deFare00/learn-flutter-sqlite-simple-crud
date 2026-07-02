# 📚 Flutter Day 2 — Flutter Development & SQLite

Repository ini merupakan bagian dari perjalanan belajar Flutter yang berfokus pada implementasi **SQLite** sebagai database lokal. Pada pembelajaran ini, aplikasi **Student Management App** dikembangkan untuk memahami konsep penyimpanan data lokal menggunakan package `sqflite` serta implementasi operasi **CRUD (Create, Read, Update, Delete)**.

---

## 🎯 Learning Objectives

Setelah menyelesaikan project ini, saya berhasil mempelajari:

* Memahami konsep Local Database pada Flutter.
* Mengenal SQLite sebagai database lokal.
* Mengintegrasikan package `sqflite`.
* Membuat dan mengelola database SQLite.
* Membuat tabel menggunakan SQL.
* Mengimplementasikan operasi CRUD (Create, Read, Update, Delete).
* Menggunakan `FutureBuilder` untuk menampilkan data asynchronous.
* Membangun Form dengan validasi.
* Menggunakan `TextEditingController`.
* Menerapkan struktur project Flutter yang rapi.
* Membuat reusable widget.
* Menghubungkan UI dengan database SQLite.

---

## 🚀 Features

* ✅ Student List
* ✅ Add Student
* ✅ Edit Student
* ✅ Delete Student
* ✅ Form Validation
* ✅ SQLite Local Database
* ✅ FutureBuilder
* ✅ Reusable Student Card
* ✅ Material Design UI

---

## 🏗️ Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
│
├── database/
│   └── database_helper.dart
│
├── models/
│   └── student.dart
│
├── pages/
│   ├── home_page.dart
│   ├── add_student_page.dart
│   └── edit_student_page.dart
│
├── widgets/
│   └── student_card.dart
│
└── main.dart
```

---

## 📦 Dependencies

```yaml
sqflite
path
path_provider
```

---

## 🗄️ Database Schema

### Table: `students`

| Column | Type    | Description                  |
| ------ | ------- | ---------------------------- |
| id     | INTEGER | Primary Key (Auto Increment) |
| name   | TEXT    | Student Name                 |
| age    | INTEGER | Student Age                  |

SQL Schema:

```sql
CREATE TABLE students(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  age INTEGER NOT NULL
);
```

---

## 📱 CRUD Flow

### Create

* Input student data.
* Validate form.
* Save to SQLite.

### Read

* Retrieve data from SQLite.
* Display using `FutureBuilder` and `ListView.builder`.

### Update

* Open edit page.
* Update selected student.
* Save changes to SQLite.

### Delete

* Show confirmation dialog.
* Delete selected student.
* Refresh student list.

---

## 🧠 Concepts Learned

* Flutter Local Database
* SQLite
* SQL Basics
* Future & Async/Await
* FutureBuilder
* StatefulWidget
* Form Validation
* TextEditingController
* Navigation
* Singleton Pattern
* Model Class
* Database Helper
* Separation of Concerns
* Reusable Widget
* Material Design

---

## 📸 Application Flow

```text
Home Page
     │
     ├── Add Student
     │       │
     │       ▼
     │   SQLite Database
     │
     ├── Edit Student
     │       │
     │       ▼
     │   SQLite Database
     │
     └── Delete Student
             │
             ▼
        SQLite Database
```

---

## 📈 What I Learned

Melalui project ini, saya memahami bagaimana Flutter berinteraksi dengan SQLite melalui package `sqflite`. Saya juga mempelajari cara membangun aplikasi CRUD sederhana dengan struktur project yang rapi, memisahkan model, database, halaman, dan widget agar kode lebih mudah dikembangkan dan dipelihara.

Project ini menjadi fondasi penting sebelum mempelajari **State Management** menggunakan Provider pada tahap pembelajaran berikutnya.

---

## 🛠️ Tech Stack

* Flutter
* Dart
* SQLite
* sqflite
* path
* path_provider
* Material Design

---

## 📅 Learning Roadmap

* ✅ Day 1 — Flutter Fundamentals
* ✅ Day 2 — Flutter Development & SQLite
* 🔜 Day 3 — State Management (Provider)

---

## 👨‍💻 Author

Developed as part of my Flutter learning journey to strengthen mobile application development skills using Flutter and SQLite.
