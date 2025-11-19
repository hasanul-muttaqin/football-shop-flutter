# football_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tugas 7

- Apa itu widget tree pada Flutter dan bagaimana hubungan parent-child bekerja antar widget?
  - Widget tree adalah susunan hierarkis semua widget yang membentuk UI. Setiap widget bisa memiliki anak (child/children). Parent memberi batasan layout kepada child. Child merespons dengan ukuran/paint sesuai. Perubahan pada node tertentu memicu rebuild pada subtree terkait.

- Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
  - `MaterialApp`: Pembungkus aplikasi Material yang menyediakan tema, routing, dan localizations.
  - `ThemeData`/`ColorScheme`: Mengatur tema dan skema warna aplikasi.
  - `Scaffold`: Kerangka halaman Material (app bar, body, snackbar).
  - `AppBar`: Bilah atas dengan judul.
  - `Center`: Memusatkan child.
  - `Padding`: Memberi jarak di sekeliling konten.
  - `Column`: Menyusun children secara vertikal.
  - `SizedBox`: Memberi jarak/ukuran tetap.
  - `ElevatedButton.icon`: Tombol dengan ikon dan teks.
  - `Icon`/`Icons`: Menampilkan ikon Material.
  - `Text`: Menampilkan teks.
  - `SnackBar`: Pesan sementara di bagian bawah.
  - `ScaffoldMessenger`: Menampilkan/menyembunyikan `SnackBar` pada `Scaffold` aktif.

- Apa fungsi dari widget MaterialApp? Mengapa sering digunakan sebagai widget root?
  - `MaterialApp` menyediakan konfigurasi level-aplikasi seperti tema (`Theme`), navigator/routing, dan localizations. Karena banyak widget Material membutuhkan konteks ini, `MaterialApp` lazim jadi root agar subtree memperoleh konfigurasi konsisten.

- Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan memilih salah satunya?
  - `StatelessWidget`: Tidak punya state yang berubah, UI murni dari input. Gunakan untuk tampilan statis/presentasional.
  - `StatefulWidget`: Memiliki `State` yang bisa berubah (via `setState`). Gunakan saat UI bereaksi terhadap interaksi, animasi, atau data dinamis.

- Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
  - `BuildContext` adalah referensi ke posisi widget pada tree. Dipakai untuk mengakses data dari ancestor (mis. `Theme.of(context)`, `ScaffoldMessenger.of(context)`), navigasi, dan lookup `InheritedWidget`. Dalam `build`, kita meneruskan `context` ke widget/utility yang memerlukannya.

- Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
  - Hot reload menambahkan perubahan kode ke VM dan menjalankan ulang `build` tanpa mengulang inisialisasi state—state saat ini dipertahankan.
  - Hot restart me-restart aplikasi dari awal: state direset, `main()` dijalankan ulang. Digunakan bila perubahan memengaruhi inisialisasi global.

## Tugas 8

- Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
  - `Navigator.push()` menambahkan halaman baru di atas stack, sehingga pengguna dapat kembali ke halaman sebelumnya dengan tombol back. Cocok saat membuka halaman formulir Tambah Produk dari beranda agar pengguna bisa kembali ke beranda tanpa menutup aplikasi.
  - `Navigator.pushReplacement()` mengganti halaman saat ini dengan halaman baru (halaman lama dihapus dari stack). Cocok untuk navigasi dari Drawer ke Halaman Utama agar tidak menumpuk banyak halaman home di stack saat pengguna berkali-kali memilih menu yang sama.

- Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
  - `Scaffold` menyediakan kerangka halaman (AppBar, body, Drawer, SnackBar). `AppBar` memberi identitas halaman. `Drawer` menyediakan navigasi antar halaman (Halaman Utama dan Tambah Produk). Dengan pola ini, setiap halaman memiliki kerangka antarmuka yang sama sehingga pengalaman pengguna konsisten.

- Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
  - `Padding` memberi ruang antar elemen sehingga form lebih mudah dibaca dan disentuh; digunakan di setiap field form. `SingleChildScrollView` memungkinkan konten form di-scroll saat tinggi layar terbatas/keyboard muncul; membungkus kolom form pada halaman Tambah Produk. `ListView` atau `Column` dengan scroll memudahkan komposisi banyak input secara vertikal tanpa overflow.

- Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
  - Mengatur `ThemeData` dengan `ColorScheme.fromSeed(seedColor: Colors.green)` untuk theme hijau sebagai warna brand. Konsisten memakai variasi warna ini pada AppBar, Drawer header, dan aksen tombol sehingga seluruh komponen konsisten.

## Tugas 9

- Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model (terkait validasi tipe, null-safety, maintainability)?
  - Model seperti `Product` menjadikan struktur data eksplisit (tipe field, nilai opsional/wajib, konversi tanggal). Kita bisa menerapkan validasi ketika parsing (mis. memastikan `price` bertipe `int` dan `is_featured` bertipe `bool`). Jika hanya memakai `Map<String, dynamic>`, kesalahan penulisan key atau perubahan struktur JSON baru terdeteksi saat runtime (NoSuchMethod, null dereference), membuat kode rentan bug dan sulit dirawat. Dengan model, IDE dapat memberi autocompletion dan kompilator dapat mengecek null-safety.

- Jelaskan apa fungsi package `http` dan `CookieRequest` dalam tugas ini, serta perbedaan peran `http` vs `CookieRequest`.
  - `http` dipakai untuk operasi HTTP biasa tanpa state (mis. Image.network). `CookieRequest` membungkus `http.Client` dan menyimpan cookie sesi Django sehingga login, post JSON, dan get JSON berbasis autentikasi bisa berbagi state. Perbedaannya: `http` stateless dan cocok untuk request publik, sedangkan `CookieRequest` mempertahankan session + header CSRF secara otomatis khusus untuk integrasi dengan pbp Django Auth.

- Jelaskan mengapa instance `CookieRequest` perlu dibagikan ke semua komponen di aplikasi Flutter.
  - Karena cookie sesi disimpan pada instance `CookieRequest`, setiap komponen yang memanggil endpoint butuh akses ke instance yang sama agar header/cookie yang sudah terbentuk saat login ikut terkirim. Jika setiap widget membuat `CookieRequest` sendiri, autentikasi tidak terbawa (cookie kosong), sehingga endpoint seperti `/json/?mine=1` atau `/products/create-mobile/` akan selalu dianggap belum login. Dengan `Provider<CookieRequest>` di `main.dart`, seluruh subtree membaca instance yang sama.

- Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan `10.0.2.2` pada `ALLOWED_HOSTS`, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
  - Emulator Android mengakses host mesin melalui `10.0.2.2`, sehingga domain ini wajib ditambahkan pada `ALLOWED_HOSTS` dan `CSRF_TRUSTED_ORIGINS` agar Django menerima request. `django-cors-headers` diaktifkan supaya permintaan lintas origin (terutama saat release via domain pbp) dapat membawa cookie (`CORS_ALLOW_CREDENTIALS=True`) dan tidak diblokir. Pengaturan `SESSION_COOKIE_SAMESITE`/`CSRF_COOKIE_SAMESITE` memastikan cookie boleh dibaca oleh Flutter release (HTTPS) tanpa dianggap cross-site berbahaya. Di sisi Flutter, izin `android.permission.INTERNET` dibutuhkan agar aplikasi boleh membuka koneksi HTTP. Jika salah satu konfigurasi absen, request akan gagal (403 host tidak diizinkan, cookie tidak pernah terset sehingga login selalu gagal, atau aplikasi Android tidak bisa membuka koneksi sama sekali).

- Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
  - Contohnya alur tambah produk: pengguna mengisi form pada `ProductFormPage`. Setelah validasi, data dikirim menggunakan `CookieRequest.postJson` ke endpoint Django `/products/create-mobile/`. View Django mem-parsing JSON, membuat `Product` baru, dan membalas JSON sukses. Ketika halaman daftar dipanggil, Flutter menggunakan `CookieRequest.get` ke `/json/` (atau `/json/?mine=1`), menerima deretan JSON produk, memetakannya ke objek `Product`, lalu `ProductListPage` menampilkan card sesuai atribut (nama, harga, deskripsi, kategori, thumbnail, status unggulan).

- Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
  - Registrasi: Flutter menembak endpoint `/auth/register/` dengan JSON `{username, password1, password2}`. Django `UserCreationForm` memvalidasi dan membuat akun baru.
  - Login: `LoginPage` memanggil `request.login` ke `/auth/login/`, Django memverifikasi kredensial dan memanggil `login()` sehingga sessionid dikirim sebagai cookie. `CookieRequest` menyimpan cookie tersebut dan menandai `loggedIn=true`, sehingga root widget mengganti tampilan menjadi `HomePage`.
  - Logout: Drawer memanggil `/auth/logout/`, Django memanggil `logout()` dan menghapus cookie. `CookieRequest` mengosongkan sesi sehingga pengguna diarahkan kembali ke `LoginPage`.

- Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial).
  1. Memastikan backend siap pakai: memperbarui `ALLOWED_HOSTS`, CORS, dan menambahkan endpoint JSON/login/register khusus Flutter pada proyek Django `eshop_pbp`.
  2. Menambahkan dependency Flutter (`provider`, `pbp_django_auth`, `http`, `intl`) lalu membangun kerangka arsitektur baru dengan `Provider<CookieRequest>` di `main.dart`.
  3. Membuat halaman `LoginPage` dan `RegisterPage`, serta drawer dengan aksi logout agar autentikasi bisa dilakukan langsung dari Flutter.
  4. Membangun model `Product`, layanan konfigurasi `ApiConfig`, daftar produk (`ProductListPage`), dan halaman detail yang menampilkan seluruh atribut item.
  5. Memutakhirkan form produk agar mengirim data ke Django menggunakan endpoint baru dan memvalidasi semua field sesuai model backend.
  6. Menambahkan filter "Produk Saya" (menggunakan query `mine=1`) untuk menampilkan data yang terkait dengan akun login.