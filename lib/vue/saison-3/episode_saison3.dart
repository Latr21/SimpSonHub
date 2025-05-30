import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_card.dart'; // ✅ bon chemin
class EpisodeSaison3 extends StatelessWidget {
  const EpisodeSaison3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> episodesFictifs = [
      'Épisode 1 : Le procès de Krusty',
      'Épisode 2 : Bart devient maire',
      'Épisode 3 : Homer et le donut géant',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Saison 3',
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
                    Navigator.pushNamed(context, '/episode1saison3');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/episode2saison3');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/episode3saison3');
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