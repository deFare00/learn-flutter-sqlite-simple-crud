# Design System

# Student Attendance Management

**Version:** 1.0

---

# 1. Overview

Design System merupakan standar visual yang digunakan pada seluruh halaman aplikasi.

Dokumen ini bertujuan untuk menjaga konsistensi tampilan, meningkatkan pengalaman pengguna, serta mempermudah pengembangan komponen UI yang reusable.

Seluruh implementasi UI harus mengacu pada dokumen ini.

---

# 2. Design Principles

Project menerapkan prinsip berikut.

* Clean
* Modern
* Minimalist
* Professional
* Consistent
* Responsive
* Accessible
* Material Design 3

---

# 3. Color Palette

## Primary

| Name          | Hex     |
| ------------- | ------- |
| Primary       | #1078CA |
| Primary Light | #4A9BE0 |
| Primary Dark  | #0C5EA1 |

---

## Secondary

| Name      | Hex     |
| --------- | ------- |
| Secondary | #34C759 |

---

## Neutral

| Name       | Hex     |
| ---------- | ------- |
| Background | #F8FAFC |
| Surface    | #FFFFFF |
| Border     | #E5E7EB |
| Divider    | #F1F5F9 |

---

## Text

| Name           | Hex     |
| -------------- | ------- |
| Primary Text   | #1E293B |
| Secondary Text | #64748B |
| Hint Text      | #94A3B8 |

---

## Status

| Name    | Hex     |
| ------- | ------- |
| Success | #22C55E |
| Warning | #F59E0B |
| Error   | #EF4444 |
| Info    | #3B82F6 |

---

# 4. Typography

Menggunakan font bawaan Flutter (Roboto) atau font yang dikonfigurasi pada project.

| Style           | Size | Weight   |
| --------------- | ---- | -------- |
| Display Large   | 36   | Bold     |
| Headline Large  | 30   | Bold     |
| Headline Medium | 24   | SemiBold |
| Title Large     | 20   | SemiBold |
| Title Medium    | 18   | Medium   |
| Body Large      | 16   | Regular  |
| Body Medium     | 14   | Regular  |
| Label Large     | 14   | SemiBold |
| Label Medium    | 12   | Medium   |

---

# 5. Border Radius

Gunakan radius yang konsisten.

| Component    | Radius |
| ------------ | ------ |
| Button       | 12     |
| TextField    | 12     |
| Card         | 16     |
| Dialog       | 20     |
| Bottom Sheet | 24     |

---

# 6. Spacing

Gunakan sistem spacing berbasis kelipatan 4.

| Name | Value |
| ---- | ----- |
| XS   | 4     |
| SM   | 8     |
| MD   | 16    |
| LG   | 24    |
| XL   | 32    |
| XXL  | 48    |

---

# 7. Elevation

| Component | Elevation |
| --------- | --------- |
| Card      | 2         |
| AppBar    | 0         |
| Dialog    | 4         |

Gunakan shadow seminimal mungkin agar tampilan tetap modern.

---

# 8. Buttons

## Primary Button

Digunakan untuk aksi utama.

Contoh:

* Save
* Add Student
* Update
* Scan QR

Karakteristik:

* Filled Button
* Primary Color
* White Text
* Radius 12
* Tinggi 48 px

---

## Secondary Button

Digunakan untuk aksi pendukung.

Contoh:

* Cancel
* Back

Karakteristik:

* Outlined Button
* Primary Border
* Radius 12

---

## Text Button

Digunakan untuk aksi ringan.

Contoh:

* Learn More
* Retry

---

# 9. Text Field

Semua input menggunakan style yang sama.

Karakteristik:

* Filled
* Radius 12
* Padding konsisten
* Prefix Icon (opsional)
* Suffix Icon (opsional)
* Validation Support

---

# 10. Card

Card digunakan untuk menampilkan informasi.

Karakteristik:

* Background putih
* Radius 16
* Elevation 2
* Padding 16
* Margin 8

Contoh penggunaan:

* Student Card
* Dashboard Card
* QR Card

---

# 11. App Bar

Karakteristik:

* Background putih
* Elevation 0
* Center Title
* Primary Text Color
* Back Button otomatis

---

# 12. Dialog

Gunakan dialog yang konsisten.

Jenis dialog:

* Confirmation
* Success
* Error
* Warning

Semua dialog menggunakan:

* Radius 20
* Padding 24
* Action Button konsisten

---

# 13. Icons

Gunakan Material Symbols.

Ukuran standar:

| Type   | Size |
| ------ | ---- |
| Small  | 18   |
| Medium | 24   |
| Large  | 32   |

---

# 14. Images

Gunakan folder berikut.

```text
assets/
│
├── icons/
├── images/
└── illustrations/
```

Semua asset harus didaftarkan pada `pubspec.yaml`.

---

# 15. Page Layout

Gunakan struktur berikut.

```text
Scaffold
    │
    ├── AppBar
    ├── Body
    └── FloatingActionButton (opsional)
```

Gunakan `SafeArea` pada seluruh halaman.

---

# 16. Responsive Design

Project harus tetap nyaman digunakan pada berbagai ukuran layar.

Prinsip:

* Hindari ukuran tetap jika tidak diperlukan.
* Gunakan `Expanded`, `Flexible`, dan `LayoutBuilder` bila sesuai.
* Hindari overflow.

---

# 17. Reusable Components

Komponen berikut harus dibuat sebagai reusable widget.

* PrimaryButton
* SecondaryButton
* AppTextField
* AppCard
* StudentCard
* LoadingWidget
* EmptyState
* AppDialog
* SectionTitle

Semua komponen disimpan pada folder yang sesuai dengan ruang lingkup penggunaannya.

---

# 18. UI States

Setiap halaman minimal memiliki state berikut.

* Loading
* Empty
* Success
* Error

Hindari halaman kosong tanpa informasi.

---

# 19. Accessibility

Perhatikan hal berikut.

* Kontras warna yang cukup.
* Ukuran teks mudah dibaca.
* Area sentuh minimal 48x48 px.
* Gunakan label yang jelas pada tombol dan input.

---

# 20. Design Rules

Seluruh implementasi UI wajib mengikuti aturan berikut.

* Gunakan Global Theme.
* Jangan menggunakan hardcoded color.
* Jangan menggunakan hardcoded TextStyle.
* Gunakan AppColors.
* Gunakan AppSizes.
* Gunakan AppStrings.
* Gunakan ThemeData.
* Gunakan reusable widget.
* Jaga konsistensi spacing dan typography.

---

# 21. Design Goals

Design System ini dibuat agar:

* Tampilan aplikasi konsisten.
* Pengembangan UI lebih cepat.
* Komponen mudah digunakan kembali.
* Mudah melakukan perubahan branding.
* Mendukung penambahan fitur baru tanpa mengubah gaya visual aplikasi.
* Menghasilkan aplikasi dengan tampilan modern dan profesional.
