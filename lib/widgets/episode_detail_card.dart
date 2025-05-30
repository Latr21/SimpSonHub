import 'package:flutter/material.dart';

class EpisodeDetailCard extends StatelessWidget {
  final String resume;
  final List<String> personnages;

  const EpisodeDetailCard({
    super.key,
    required this.resume,
    required this.personnages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Résumé :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(resume),
        const SizedBox(height: 20),
        const Text(
          'Personnages :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...personnages.map((p) => Text('- $p')).toList(),
      ],
    );
  }
}