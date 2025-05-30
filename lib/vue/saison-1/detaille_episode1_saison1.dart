import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode1Saison1 extends StatelessWidget {
  const DetailleEpisode1Saison1({super.key});

  @override
  Widget build(BuildContext context) {
    final resume =
        'Bart passe un test d’intelligence et est envoyé dans une école de surdoués.';
    final personnages = [
      'Bart Simpson',
      'Homer Simpson',
      'Marge Simpson',
      'Principal Skinner',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 1 - Saison 1',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 245, 245, 245),
        padding: const EdgeInsets.all(20),
        child: EpisodeDetailCard(
          resume: resume,
          personnages: personnages,
        ),
      ),
    );
  }
}