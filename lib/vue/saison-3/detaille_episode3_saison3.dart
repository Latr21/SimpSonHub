import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode3Saison3 extends StatelessWidget {
  const DetailleEpisode3Saison3({super.key});

  @override
  Widget build(BuildContext context) {
    final resume = 'Homer se bat contre un donut géant possédé.';
    final personnages = ['Homer Simpson', 'Lenny', 'Carl', 'Donut Géant'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 3 - Saison 3',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 245, 245, 245),
        padding: const EdgeInsets.all(20),
        child: EpisodeDetailCard(
          resume: resume,
          personnages: personnages,
        ),
      ),
    );
  }
}