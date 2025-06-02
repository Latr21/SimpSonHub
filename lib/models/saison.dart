class Saison {
  final String id;
  final int numero;
  final String titre;
  final String image;

  Saison({
    required this.id,
    required this.numero,
    required this.titre,
    required this.image,
  });

  factory Saison.fromJson(Map<String, dynamic> json) {
    return Saison(
      id: json['_id'] as String,
      numero: json['numero'] != null ? json['numero'] as int : 0,
      titre: json['titre'] as String? ?? 'Saison ${json['numero'] ?? '?'}',
      image: json['image'] as String? ?? '',
    );
  }
}