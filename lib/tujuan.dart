import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange, // Menyesuaikan warna background
      appBar: AppBar(
        title: const Text(
          "Ini Halaman Tujuan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Menghilangkan panah 'back' bawaan di pojok kiri atas agar persis seperti gambar
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). Metode push() akan menambahkan Route ke dalam tumpukan Route yang dikelola oleh Navigator. Route ini dapat dibuat secara kustom atau menggunakan MaterialPageRoute, yang memiliki animasi transisi sesuai dengan platform yang digunakan.",
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 25),

            // Pengganti gambar pulau menggunakan Icon bawaan Flutter
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.beach_access, size: 100, color: Colors.black87),
            ),

            const SizedBox(height: 25),
            const Text(
              "Untuk menutup halaman kedua dan kembali ke halaman pertama, gunakan metode Navigator.pop(). Metode pop() akan menghapus Route saat ini dari tumpukan Route yang dikelola oleh Navigator.",
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Tombol warna biru
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                // Perintah untuk kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: const Text("< Kembali ke home", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}