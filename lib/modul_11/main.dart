import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart'; // Karena home.dart ada sejajar di folder modul_11

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wajib menggunakan GetMaterialApp untuk Modul 11
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      title: 'Tasbih Digital GetX',
      home: Home(),
    );
  }
}