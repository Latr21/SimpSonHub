import 'package:flutter/material.dart';
import '../models/personnage.dart';
import '../services/api_service.dart';
import '../widgets/personnage_card.dart';
import 'detail_personnage.dart';  

class Personnages extends StatelessWidget {
  const Personnages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Personnages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.grey),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Personnage>>(
        future: ApiService.getPersonnages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun personnage trouvé.'));
          }
          final personnages = snapshot.data!;
          return Container(
            color: const Color.fromARGB(255, 245, 245, 245),
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: personnages
                  .map(
                    (p) => PersonnageCard(
                      personnage: p,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPersonnage(personnage: p),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}