import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ValueNotifier<double> _valueNotifier;
  late double counter;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0.0); // Inisialisasi awal progress bar
    counter = 0.0; // Inisialisasi awal hitungan
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  // Method untuk menambah hitungan maksimal 33
  void incrementCounter() {
    setState(() {
      if (counter < 33) {
        counter++;
        _valueNotifier.value = (counter / 33) * 100;
      }
    });
  }

  // Method untuk mereset hitungan kembali ke 0
  void resetCounter() {
    setState(() {
      counter = 0.0;
      _valueNotifier.value = (counter / 33) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Membuat status bar transparan
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 119, 210, 145)),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 119, 210, 145), // Latar belakang hijau
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(counter.round())}', // Menampilkan angka kecil di atas
                  style: const TextStyle(fontSize: 50),
                ),
                SimpleCircularProgressBar(
                  progressColors: [Colors.amberAccent.shade400], // Warna garis kuning
                  size: 300,
                  progressStrokeWidth: 20,
                  backStrokeWidth: 10,
                  mergeMode: true,
                  maxValue: 100,
                  animationDuration: 0,
                  valueNotifier: _valueNotifier,
                  onGetText: (value) {
                    return Text(
                      '${(value.toInt() / 3).round()}', // Menampilkan angka besar di tengah
                      style: const TextStyle(fontSize: 170),
                    );
                  },
                ),
                const SizedBox(height: 50),
                // Tombol berbentuk sidik jari untuk menambah tasbih
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: InkWell(
                    onTap: incrementCounter,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Icon(
                        Icons.fingerprint,
                        size: 125,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Tombol melayang di pojok kanan bawah untuk mereset tasbih
        floatingActionButton: FloatingActionButton(
          onPressed: resetCounter,
          child: const Icon(Icons.refresh_outlined),
        ),
      ),
    );
  }
}