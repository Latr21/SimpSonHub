import 'package:flutter/material.dart';

class PersonnageCard extends StatelessWidget {
  final String nom;

  const PersonnageCard({super.key, required this.nom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.yellow,
      child: Center(
        child: Text(
          nom,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}