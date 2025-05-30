import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_card.dart'; // ✅ bon chemin
class EpisodeSaison2 extends StatelessWidget {
  const EpisodeSaison2({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> episodesFictifs = [
      'Épisode 1 : Le retour de Bob',
      'Épisode 2 : Homer devient chef',
      'Épisode 3 : Lisa et les dauphins',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Saison 2',
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
      body: Container(
        color: const Color.fromARGB(255, 245, 245, 245),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: episodesFictifs.asMap().entries.map((entry) {
            final index = entry.key;
            final titre = entry.value;
            return EpisodeCard(
              titre: titre,
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/episode1saison2');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/episode2saison2');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/episode3saison2');
                    break;
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}