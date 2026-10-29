import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/home.dart';
import 'view/detail.dart'; // Mengimpor halaman detail

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    // Menggunakan named routes untuk navigasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Game Store',
      initialRoute: '/', // Rute awal yang dipanggil
      routes: {
        '/': (context) => const Home(),
        '/detail': (context) {
          // Menangkap ID game yang dikirim dari Home untuk ditampilkan detailnya
          final gameId = ModalRoute.of(context)!.settings.arguments as int;
          return Detail(gameTerpilih: gameId);
        },
      },
    );
  }
}