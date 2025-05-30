import 'package:flutter/material.dart';
import '../widgets/personnage_card.dart';

class Personnages extends StatelessWidget {
  const Personnages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> personnages = [
      'Homer Simpson',
      'Marge Simpson',
      'Bart Simpson',
      'Lisa Simpson',
      'Maggie Simpson',
      'Ned Flanders',
      'Mr. Burns',
      'Krusty le clown',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Personnages',
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
          children: personnages
              .map((nom) => PersonnageCard(nom: nom))
              .toList(),
        ),
      ),
    );
  }
}