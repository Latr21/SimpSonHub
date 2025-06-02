import 'package:flutter/material.dart';
import '../widgets/episode_detail_card.dart';
import '../services/api_service.dart';

class DetailEpisodePage extends StatelessWidget {
  final String episodeId;

  const DetailEpisodePage({super.key, required this.episodeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Détail de l\'épisode',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getEpisodeByIdComplete(episodeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final resume = data['resume'] is String
                ? data['resume']
                : (data['resume']?['texte'] ?? '');

            // Récupérer la liste complète des personnages (objets Map)
            final List<dynamic> personnagesData = data['personnages'] ?? [];

            return Container(
              color: const Color.fromARGB(255, 245, 245, 245),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Résumé :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(resume),
                  const SizedBox(height: 20),
                  const Text(
                    'Personnages :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Afficher chaque personnage avec image et nom
                  ...personnagesData.map((p) {
                    final String nom = p['nom'] ?? 'Nom inconnu';
                    final String imageUrl = p['image'] ?? '';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          if (imageUrl.isNotEmpty)
                            Image.network(
                              imageUrl,
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person),
                            )
                          else
                            const Icon(Icons.person, size: 40),
                          const SizedBox(width: 10),
                          Text(nom),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Épisode non trouvé.'));
          }
        },
      ),
    );
  }
}