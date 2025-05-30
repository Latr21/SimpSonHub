import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode2Saison2 extends StatelessWidget {
  const DetailleEpisode2Saison2({super.key});

  @override
  Widget build(BuildContext context) {
    final resume = 'Homer devient le chef de la centrale nucléaire.';
    final personnages = ['Homer Simpson', 'Mr. Burns', 'Lenny', 'Carl'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 2 - Saison 2',
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