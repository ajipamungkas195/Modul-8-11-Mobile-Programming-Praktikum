import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen_arguments.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  // Nama rute yang digunakan untuk memanggil halaman ini
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Membuat status bar transparan
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // Mengambil data yang dikirim dari halaman Home melalui ScreenArguments
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F8FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Menampilkan gambar cover dari API
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          args.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Menampilkan judul game
                      Text(
                        args.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Menampilkan deskripsi game
                      Text(
                        args.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Tombol kembali ke halaman Home
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0081c9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 15,
                              color: Color(0xFFF4F8FB),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kembali ke game',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFF4F8FB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}