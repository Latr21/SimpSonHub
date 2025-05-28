import 'package:flutter/material.dart'; // À AJOUTER EN HAUT DE TON FICHIER
import '../vue/accueil.dart';
import '../vue/episode_saison1.dart';
import '../vue/episode_saison2.dart';
import '../vue/episode_saison3.dart';
import '../vue/personnages.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Accueil(),
  '/saison1': (context) => const EpisodeSaison1(),
  '/saison2': (context) => const EpisodeSaison2(),
  '/saison3': (context) => const EpisodeSaison3(),
  '/personnages': (context) => const Personnages(),
};