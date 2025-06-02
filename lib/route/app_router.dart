import 'package:flutter/material.dart';

// Import correct avec noms exacts de fichiers et classes
import '../vue/admincreation.dart';
import '../vue/liste_episodes.dart';
import '../vue/detail_episode_page.dart';
import '../vue/accueil.dart';
import '../vue/personnages.dart';
import '../vue/connexion.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Accueil(),
  '/create': (context) => const AdminCreation(),
  '/personnages': (context) => const Personnages(),
  '/login': (context) => const Connexion(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');

  if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'saison') {
    final saisonId = uri.pathSegments[1];
    return MaterialPageRoute(
      builder: (context) => ListeEpisodes(saisonId: saisonId),
      settings: settings,
    );
  }

  if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'episode') {
    final episodeId = uri.pathSegments[1];
    return MaterialPageRoute(
      builder: (context) => DetailEpisodePage(episodeId: episodeId),
      settings: settings,
    );
  }

  // Route par défaut
  return MaterialPageRoute(
    builder: (context) => const Accueil(),
    settings: settings,
  );
}