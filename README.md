# Course Explorer

Course Explorer merupakan aplikasi berbasis Flutter yang digunakan untuk menampilkan dan mengelola informasi mata kuliah. Aplikasi ini menyediakan fitur untuk melihat daftar mata kuliah, menambahkan data, mengubah data, menghapus data, melihat detail, serta menandai mata kuliah sebagai favorit.

Aplikasi ini menggunakan Provider sebagai state management dan menerapkan Repository Pattern untuk memisahkan pengelolaan tampilan, state, dan akses data. Supabase digunakan sebagai backend dan database untuk menyimpan informasi mata kuliah.

## Fitur Aplikasi

- Menampilkan daftar mata kuliah.
- Melihat detail mata kuliah.
- Menambahkan mata kuliah baru.
- Mengubah informasi mata kuliah.
- Menghapus mata kuliah.
- Menandai mata kuliah sebagai favorit.
- Menampilkan loading, error, empty state, dan fitur retry.
- Mendukung tampilan responsif.

## Struktur Folder dan Tanggung Jawab

### 1. Models

Folder `lib/models/` berisi representasi data yang digunakan dalam aplikasi. File `course.dart` mendefinisikan struktur objek mata kuliah beserta proses pemetaan data.

### 2. Services

Folder `lib/services/` bertugas menangani komunikasi dengan sumber data.

- `course_data_source.dart` mendefinisikan kontrak sumber data.
- `course_api_service.dart` menangani komunikasi dengan REST API.
- `course_supabase_service.dart` menangani operasi data menggunakan Supabase.

### 3. Repositories

Folder `lib/repositories/` berisi `course_repository.dart` yang menjadi penghubung antara Provider dan sumber data. Repository mengatur proses pengambilan, penambahan, perubahan, dan penghapusan data mata kuliah.

### 4. Providers

Folder `lib/providers/` berisi `course_provider.dart` yang menggunakan ChangeNotifier untuk mengelola state aplikasi, seperti daftar mata kuliah, status loading, error, proses penyimpanan, dan daftar favorit.

### 5. Screens

Folder `lib/screens/` berisi halaman-halaman aplikasi, seperti Home, Courses, Course Detail, Favorites, Profile, Add Course, dan Edit Course.

### 6. Widgets

Folder `lib/widgets/` berisi komponen tampilan yang dapat digunakan kembali, seperti Course Card dan Error View.

### 7. Config

Folder `lib/config/` berisi konfigurasi koneksi backend, termasuk URL project dan publishable key Supabase.

## Arsitektur Aplikasi

Aplikasi menerapkan arsitektur berlapis dengan alur dependency sebagai berikut:

**Screen / Widget → Provider → Repository → Data Source / Service → Supabase**

Setiap bagian memiliki tanggung jawab yang berbeda. Screen dan Widget berfokus pada tampilan, Provider mengelola state, Repository mengatur akses data, sedangkan Data Source dan Service menangani komunikasi dengan backend.

## REST API

Pada tahap awal pengembangan, aplikasi menggunakan REST API untuk mempelajari komunikasi antara Flutter dan backend.

- **Endpoint:** `https://course-api-pearl.vercel.app/courses`
- **Method:** GET, POST, PUT/PATCH, dan DELETE
- **Resource:** `courses`

Field data yang digunakan meliputi:

| Field | Keterangan |
|---|---|
| `id` | ID