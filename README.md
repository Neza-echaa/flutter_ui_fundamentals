# Course Explorer

Course Explorer merupakan aplikasi Flutter untuk menampilkan dan mengelola informasi mata kuliah. Aplikasi ini menggunakan Provider sebagai state management dan menerapkan arsitektur berlapis agar setiap bagian memiliki tanggung jawab yang jelas.

## Struktur Folder dan Tanggung Jawab

### 1. Models
Folder `lib/models/` berisi struktur atau representasi data yang digunakan dalam aplikasi. Contohnya, `course.dart` digunakan untuk mendefinisikan objek mata kuliah.

### 2. Services
Folder `lib/services/` bertugas mengambil data dari sumber data. Pada project ini, `course_service.dart` digunakan untuk membaca dan mengolah data mata kuliah dari file JSON.

### 3. Repositories
Folder `lib/repositories/` berfungsi sebagai penghubung antara Provider dan Service. Repository mengatur proses pengambilan data sebelum diberikan kepada Provider.

### 4. Providers
Folder `lib/providers/` bertugas mengelola state aplikasi menggunakan ChangeNotifier. Bagian ini mengatur data mata kuliah, status loading, pesan error, dan daftar favorit.

### 5. Screens
Folder `lib/screens/` berisi halaman utama aplikasi, seperti Home, Courses, Course Detail, Favorites, dan Profile.

### 6. Widgets
Folder `lib/widgets/` berisi komponen tampilan yang dapat digunakan kembali pada beberapa halaman, seperti Course Card dan Student Identity Card.

## Arah Dependency

Alur pengelolaan data pada aplikasi Course Explorer adalah:

**Screen/Widget → Provider → Repository → Service → Data Source**

Setiap bagian memiliki tanggung jawab masing-masing. Screen dan Widget berfokus pada tampilan, Provider mengelola state, Repository mengatur akses data, sedangkan Service bertugas membaca data dari sumbernya.