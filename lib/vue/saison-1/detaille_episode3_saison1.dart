import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode3Saison1 extends StatelessWidget {
  const DetailleEpisode3Saison1({super.key});

  @override
  Widget build(BuildContext context) {
    final resume =
        'Homer et Marge sortent pour une soirée en amoureux pendant que les enfants restent à la maison.';
    final personnages = [
      'Homer Simpson',
      'Marge Simpson',
      'Bart Simpson',
      'Lisa Simpson',
      'Grand-père Simpson',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 3 - Saison 1',
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