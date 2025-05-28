import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final String titre;

  const EpisodeCard({super.key, required this.titre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.yellow,
      child: Center(
        child: Text(
          titre,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}