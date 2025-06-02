class Episode {
  final String id;
  final String titre;
  final String resume;
  final int numero;
  final String saisonId;

  Episode({
    required this.id,
    required this.titre,
    required this.resume,
    required this.numero,
    required this.saisonId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['_id'] as String,
      titre: json['titre'] as String? ?? '',
      resume: json['resume'] as String? ?? '',
      numero: json['numero'] != null ? json['numero'] as int : 0,
      saisonId: json['saison_id'] as String? ?? '',
    );
  }
}
