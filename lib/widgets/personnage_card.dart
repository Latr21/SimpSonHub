import 'package:flutter/material.dart';
import '../models/personnage.dart';

class PersonnageCard extends StatelessWidget {
  final Personnage personnage;
  final VoidCallback onTap;

  const PersonnageCard({
    super.key,
    required this.personnage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image à gauche
            if (personnage.image.isNotEmpty)
              personnage.image.startsWith('http')
                  ? Image.network(
                      personnage.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      personnage.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
            else
              const Icon(Icons.person, size: 50),

            const SizedBox(width: 20),

            // Nom du personnage
            Text(
              personnage.nom,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}