import 'package:flutter/material.dart';
import '../models/personnage.dart';
import '../models/episode.dart';
import '../services/api_service.dart';

class DetailPersonnage extends StatefulWidget {
  final Personnage personnage;

  const DetailPersonnage({super.key, required this.personnage});

  @override
  State<DetailPersonnage> createState() => _DetailPersonnageState();
}

class _DetailPersonnageState extends State<DetailPersonnage> {
  late Future<List<Episode>> episodesFuture;

  @override
  void initState() {
    super.initState();
    // Charge les épisodes liés au personnage via l'API
    episodesFuture = ApiService.getEpisodesByPersonnage(widget.personnage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personnage.nom),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affiche la description du personnage ici
            Text(
              widget.personnage.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            const Text(
              'Épisodes :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<Episode>>(
                future: episodesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final episodes = snapshot.data!;
                    if (episodes.isEmpty) {
                      return const Text('Aucun épisode trouvé.');
                    }
                    return ListView.builder(
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        final ep = episodes[index];
                        return ListTile(
                          title: Text(ep.titre),
                          subtitle: Text(ep.resume),
                        );
                      },
                    );
                  } else {
                    return const Text('Aucun épisode trouvé.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}