import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final String titre;
  final VoidCallback? onTap;

  const EpisodeCard({super.key, required this.titre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: Colors.yellow,
        child: Center(
          child: Text(
            titre,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}