import 'package:flutter/material.dart';
import '../model/game.dart';
import '../viewmodel/fetchgame.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Game>> gameList;

  @override
  void initState() {
    super.initState();
    // Memanggil API saat layar pertama kali dimuat
    loadGames();
  }

  Future<List<Game>> loadGames() async {
    gameList = fetchGames();
    return gameList;
  }

  // Method untuk membuat widget Search Bar
  Widget _searchBar() {
    return TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        fillColor: Colors.blue.shade50,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 20,
        ),
        prefixIcon: const Icon(
          Icons.search_outlined,
          color: Colors.blue,
          size: 30,
        ),
        hintText: 'Cari game',
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7)),
      ),
    );
  }

  // Method untuk membuat tampilan tiap item di daftar game
  Widget _listItem(String urlCover, String judul, String genre) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        tileColor: Colors.blue.shade50,
        leading: SizedBox(
          width: 75,
          height: 75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              urlCover,
              scale: 3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(judul),
        subtitle: Text(genre),
        trailing: const Icon(Icons.more_vert),
        isThreeLine: false,
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              _searchBar(),
              const SizedBox(height: 10),
              // FutureBuilder untuk menangani status loading, error, dan sukses dari API
              FutureBuilder<List<Game>>(
                future: fetchGames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Tidak ada data game.');
                  } else {
                    // Mengambil maksimal 25 data game agar tidak terlalu berat
                    final games = snapshot.data!.take(25).toList();
                    return Expanded(
                      child: ListView.builder(
                        itemCount: games.length,
                        itemBuilder: (context, index) {
                          final game = games[index];
                          return GestureDetector(
                            onTap: () {
                              // Saat diklik, mengirim ID game ke halaman detail
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: game.id,
                              );
                            },
                            child: _listItem(
                              game.thumbnail,
                              game.title,
                              game.genre,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}