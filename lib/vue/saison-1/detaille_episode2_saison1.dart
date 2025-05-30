import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode2Saison1 extends StatelessWidget {
  const DetailleEpisode2Saison1({super.key});

  @override
  Widget build(BuildContext context) {
    final resume =
        'Marge engage une baby-sitter pour garder les enfants, mais tout ne se passe pas comme prévu.';
    final personnages = [
      'Marge Simpson',
      'Bart Simpson',
      'Lisa Simpson',
      'Baby-sitter',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 2 - Saison 1',
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