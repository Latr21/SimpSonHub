import 'package:flutter/material.dart';
import '../models/saison.dart';
import '../services/api_service.dart';
import '../widgets/saison_tile.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Saison> saisons = [];

  @override
  void initState() {
    super.initState();
    loadSaisons();
  }

  Future<void> loadSaisons() async {
    final data = await ApiService.getSaisons();
    setState(() {
      saisons = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'SimpSonHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
            shadows: [
              Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.grey),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.yellow),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
            ListTile(
              title: const Text('Personnages'),
              onTap: () => Navigator.pushNamed(context, '/personnages'),
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 245, 245, 245),
        child: saisons.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: saisons
                    .map(
                      (saison) => SaisonTile(
                        titre: saison.titre,
                        route: '/saison/${saison.id}', // navigation dynamique via id
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}