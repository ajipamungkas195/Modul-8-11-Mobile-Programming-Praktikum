import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tasbih_controller.dart';

// Hapus 'const' pada constructor karena kita menginisialisasi controller di dalamnya
class Home extends StatelessWidget {
  Home({super.key});

  // Menginisialisasi TasbihController
  final TasbihController controller = Get.put(TasbihController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx digunakan untuk memantau perubahan variabel counter secara real-time
              Obx(
                    () => Text(
                  '${controller.counter.value.round()}',
                  style: const TextStyle(fontSize: 250),
                ),
              ),
              // Obx juga memantau perubahan progress bar
              Obx(
                    () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: LinearProgressIndicator(
                    value: controller.progress.value / 100,
                    backgroundColor: Colors.white54,
                    color: Colors.amberAccent.shade400,
                    minHeight: 15,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 75),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: InkWell(
                  // Menghubungkan tombol dengan fungsi incrementCounter
                  onTap: controller.incrementCounter,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.all(30),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Menghubungkan tombol dengan fungsi resetCounter
        onPressed: controller.resetCounter,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.refresh_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}