import 'package:flutter/material.dart';
import '../widgets/episode_card.dart';

class EpisodeSaison2 extends StatelessWidget {
  const EpisodeSaison2({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> episodesFictifs = [
      'Épisode 1 : Bart fait grève',
      'Épisode 2 : Homer l’artiste',
      'Épisode 3 : Lisa la rebelle',
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
          children: episodesFictifs
              .map((titre) => EpisodeCard(titre: titre))
              .toList(),
        ),
      ),
    );
  }
}