import 'package:flutter/material.dart';
import '../vue/accueil.dart';
import '../vue/personnages.dart';

// Saison 1
import '../vue/saison-1/episode_saison1.dart';
import '../vue/saison-1/detaille_episode1_saison1.dart';
import '../vue/saison-1/detaille_episode2_saison1.dart';
import '../vue/saison-1/detaille_episode3_saison1.dart';

// Saison 2
import '../vue/saison-2/episode_saison2.dart';
import '../vue/saison-2/detaille_episode1_saison2.dart';
import '../vue/saison-2/detaille_episode2_saison2.dart';
import '../vue/saison-2/detaille_episode3_saison2.dart';

// Saison 3
import '../vue/saison-3/episode_saison3.dart';
import '../vue/saison-3/detaille_episode1_saison3.dart';
import '../vue/saison-3/detaille_episode2_saison3.dart';
import '../vue/saison-3/detaille_episode3_saison3.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Accueil(),

  // Saisons
  '/saison1': (context) => const EpisodeSaison1(),
  '/saison2': (context) => const EpisodeSaison2(),
  '/saison3': (context) => const EpisodeSaison3(),

  // Personnages
  '/personnages': (context) => const Personnages(),

  // Détail Épisodes Saison 1
  '/episode1saison1': (context) => const DetailleEpisode1Saison1(),
  '/episode2saison1': (context) => const DetailleEpisode2Saison1(),
  '/episode3saison1': (context) => const DetailleEpisode3Saison1(),

  // Détail Épisodes Saison 2
  '/episode1saison2': (context) => const DetailleEpisode1Saison2(),
  '/episode2saison2': (context) => const DetailleEpisode2Saison2(),
  '/episode3saison2': (context) => const DetailleEpisode3Saison2(),

  // Détail Épisodes Saison 3
  '/episode1saison3': (context) => const DetailleEpisode1Saison3(),
  '/episode2saison3': (context) => const DetailleEpisode2Saison3(),
  '/episode3saison3': (context) => const DetailleEpisode3Saison3(),
};