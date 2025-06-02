class Personnage {
  final String id;
  final String nom;
  final String image;
  final String description; // <-- ajouter ce champ

  Personnage({
    required this.id,
    required this.nom,
    required this.image,
    required this.description,

  });

  factory Personnage.fromJson(Map<String, dynamic> json) {
    return Personnage(
      id: json['_id'],
      nom: json['nom'],
      image: json['image'] ?? '',
      description: json['description'] ?? '',  // <-- récupérer la description depuis JSON

    );
  }
}