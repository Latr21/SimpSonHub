import 'package:flutter/material.dart';

class SaisonTile extends StatelessWidget {
  final String titre;
  final String route;

  const SaisonTile({
    super.key,
    required this.titre,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        splashColor: Colors.yellow.shade200,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.yellow,
          child: Center(
            child: Text(
              titre,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}