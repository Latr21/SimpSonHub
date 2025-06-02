import 'package:flutter/material.dart';
import '../models/episode.dart';
import '../services/api_service.dart';
import '../widgets/episode_card.dart';

class ListeEpisodes extends StatefulWidget {
  final String saisonId;

  const ListeEpisodes({super.key, required this.saisonId});

  @override
  State<ListeEpisodes> createState() => _ListeEpisodesState();
}

class _ListeEpisodesState extends State<ListeEpisodes> {
  late Future<List<Episode>> _episodes;

  @override
  void initState() {
    super.initState();
    _episodes = ApiService.getEpisodesBySaison(widget.saisonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Liste des épisodes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Episode>>(
        future: _episodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          final episodes = snapshot.data ?? [];
          if (episodes.isEmpty) {
            return const Center(child: Text('Aucun épisode trouvé.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return EpisodeCard(
                titre: "Épisode ${episode.numero} : ${episode.titre}",
                onTap: () {
                  Navigator.pushNamed(context, '/episode/${episode.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}