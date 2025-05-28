import 'package:flutter/material.dart';

class EpisodeSaison3 extends StatelessWidget {
  const EpisodeSaison3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> episodesFictifs = [
      'Épisode 1 : Bart le Génie',
      'Épisode 2 : La Baby-sitter',
      'Épisode 3 : Une soirée d’enfer',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Saison 1',
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
              .map((titre) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.yellow,
                      child: Center(
                        child: Text(
                          titre,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}