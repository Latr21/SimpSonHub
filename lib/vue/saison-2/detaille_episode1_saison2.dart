import 'package:flutter/material.dart';
import 'package:simp_son_hub/widgets/episode_detail_card.dart';
class DetailleEpisode1Saison2 extends StatelessWidget {
  const DetailleEpisode1Saison2({super.key});

  @override
  Widget build(BuildContext context) {
    final resume = 'Bob est de retour et il prépare un plan contre Bart.';
    final personnages = ['Bart Simpson', 'Bob', 'Homer Simpson'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Épisode 1 - Saison 2',
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