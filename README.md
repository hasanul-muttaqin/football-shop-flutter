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
