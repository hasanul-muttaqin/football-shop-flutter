
Deskripsi Tugas

Pada tugas ini, kamu akan mengimplementasikan aplikasi yang telah kamu kembangkan menggunakan Flutter berdasarkan beberapa hal yang sudah kamu pelajari selama tutorial.

Checklist untuk tugas ini adalah sebagai berikut:

1. [x] Membuat sebuah program Flutter baru dengan tema Football shop yang sesuai dengan tugas-tugas sebelumnya. 

2. [x] Membuat tiga tombol sederhana dengan ikon dan teks untuk product kamu: 

 - [x] All Products 
 - [x] My Products 
 - [x] Create Product 
3. [x] Mengimplementasikan warna-warna yang berbeda untuk setiap tombol: 

 - [x] Warna biru untuk tombol All Products 
 - [x] Warna hijau untuk tombol My Products 
 - [x] Warna merah untuk tombol Create Product 
4. [x] Memunculkan Snackbar dengan tulisan: 

 - [x] "Kamu telah menekan tombol All Products" ketika tombol All Products ditekan. 
 - [x] "Kamu telah menekan tombol My Products" ketika tombol My Products ditekan. 
 - [x] "Kamu telah menekan tombol Create Product" ketika tombol Create Product ditekan. 
5. [x] Jawab pertanyaan-pertanyaan berikut di file README.md pada folder root: 

  [x] Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
  [x] Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
  [x] Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
  [x] Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
  [x] Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
  [x] Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
 Melakukan add-commit-push ke suatu repositori baru di GitHub.


Deskripsi Tugas

 [x] Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah produk baru dengan ketentuan sebagai berikut:
 [x] Memakai minimal tiga elemen input, yaitu name, price, dan description.
 [x] Tambahkan elemen input lain sesuai dengan model pada aplikasi Football Shop Django yang telah kamu buat (misalnya thumbnail, category, dan isFeatured).
 - [x] Memiliki sebuah tombol Save.
 - [x] Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:
 - [x] Setiap elemen input tidak boleh kosong.
 - [x] Setiap elemen input harus berisi data dengan tipe data atribut modelnya.

 - [x] Perhatikan kasus seperti angka negatif, panjang string minimum/maksimum, dan format data (misalnya URL untuk thumbnail). Tidak hanya tipe datanya saja!

 [x] Mengarahkan pengguna ke halaman form tambah produk baru ketika menekan tombol Tambah Produk pada halaman utama.

 [x] Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman form tambah produk baru.

 [x] Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:

 - [x] Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Produk.
 - [x]  Ketika memilih opsi Halaman Utama, aplikasi akan mengarahkan pengguna ke halaman utama.
 - [x] Ketika memilih opsi Tambah Produk, aplikasi akan mengarahkan pengguna ke halaman form tambah produk baru.

 [x] Menjawab beberapa pertanyaan berikut pada README.md pada root folder (silakan modifikasi README.md yang telah kamu buat sebelumnya dan tambahkan subjudul untuk setiap tugas):

 - [x] Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

 - [x] Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

 - [x] Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

 - [x] Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

[] Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.
[] Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.
[] Membuat halaman login pada proyek tugas Flutter.
[] Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
[] Membuat model kustom sesuai dengan proyek aplikasi Django.
[] Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
  - [] Tampilkan name, price, description, thumbnail, category, dan is_featured dari masing-masing item pada halaman ini (dapat disesuaikan dengan field yang kalian buat sebelumnya).
[] Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar item.
  - [] Memastikan halaman detail dapat diakses dengan menekan salah satu card item pada halaman daftar item.
  - [] Tampilkan seluruh atribut pada model item kamu pada halaman detail.
  - [] Tambahkan tombol untuk kembali ke halaman daftar item pada halaman detail.
[] Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
[x] Menjawab beberapa pertanyaan berikut pada README.md pada root folder (tambahkan subjudul untuk setiap tugas):
 - [x] Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model (terkait validasi tipe, null-safety, maintainability)?
 - [x] Jelaskan apa fungsi package `http` dan `CookieRequest` dalam tugas ini, serta perbedaan peran `http` vs `CookieRequest`.
 - [x] Jelaskan mengapa instance `CookieRequest` perlu dibagikan ke semua komponen di aplikasi Flutter.
 - [x] Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan `10.0.2.2` pada `ALLOWED_HOSTS`, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
 - [x] Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
 - [x] Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
 - [x] Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial).
