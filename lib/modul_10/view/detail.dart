import 'package:flutter/material.dart';
import '../viewmodel/fetchgame.dart';
import '../model/detailgame.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatelessWidget {
  // Menerima ID game yang dikirim dari halaman Home
  final int gameTerpilih;

  const Detail({super.key, required this.gameTerpilih});

  // Fungsi untuk mengambil data detail game dari API
  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih);
    return DetailGame.fromJson(jsonData);
  }

  // Widget untuk menampilkan gambar screenshot
  SizedBox _itemList(String url) {
    return SizedBox(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget untuk merapikan teks Minimum System Requirements
  Row _requirementRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Text(title, style: TextStyle(color: Colors.black54.withOpacity(0.8)))),
        Expanded(flex: 1, child: Text(':', style: TextStyle(color: Colors.black54.withOpacity(0.8)))),
        Expanded(flex: 8, child: Text(value, style: TextStyle(color: Colors.black54.withOpacity(0.8)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          } else {
            final game = snapshot.data!;
            return Column(
              children: [
                // Header: Gambar Cover & Tombol Back
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        child: Image.network(
                          game.thumbnail,
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 15,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Kembali ke halaman sebelumnya
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Konten: Requirements, Screenshots & Deskripsi
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                'Minimum System Requirements',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54.withOpacity(0.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                _requirementRow('OS', game.minimum_system_requirements.os),
                                _requirementRow('Processor', game.minimum_system_requirements.processor),
                                _requirementRow('Memory', game.minimum_system_requirements.memory),
                                _requirementRow('Graphics', game.minimum_system_requirements.graphics),
                                _requirementRow('Storage', game.minimum_system_requirements.storage),
                              ],
                            ),
                            // Bagian Screenshots
                            Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  if (game.screenshots.isNotEmpty) _itemList(game.screenshots[0].image),
                                  const SizedBox(width: 15),
                                  if (game.screenshots.length > 1) _itemList(game.screenshots[1].image),
                                  const SizedBox(width: 15),
                                  if (game.screenshots.length > 2) _itemList(game.screenshots[2].image),
                                ],
                              ),
                            ),
                            // Bagian Deskripsi
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              child: ReadMoreText(
                                game.description,
                                trimLines: 2,
                                colorClickableText: Colors.amberAccent.shade400,
                                trimMode: TrimMode.Line,
                                style: TextStyle(
                                  color: Colors.black54.withOpacity(0.8),
                                  height: 1.5,
                                ),
                                trimCollapsedText: 'more',
                                trimExpandedText: 'less',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}