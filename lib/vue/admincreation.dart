import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/personnage.dart';  

class AdminCreation extends StatefulWidget {
  const AdminCreation({Key? key}) : super(key: key);

  @override
  State<AdminCreation> createState() => _AdminCreationState();
}

class _AdminCreationState extends State<AdminCreation> {
  final _formSaisonKey = GlobalKey<FormState>();
  final _formEpisodeKey = GlobalKey<FormState>();

  final saisonTitreController = TextEditingController();
  final episodeTitreController = TextEditingController();
  final episodeResumeController = TextEditingController();
  final episodeNumeroController = TextEditingController();
  final episodeImageController = TextEditingController();

  List<Map<String, dynamic>> saisons = [];
  String? selectedSaisonId;

  List<Personnage> allPersonnages = [];
  List<String> selectedPersonnagesIds = [];

  String messageSaison = '';
  String messageEpisode = '';

  @override
  void initState() {
    super.initState();
    fetchSaisons();
    fetchPersonnages();  // Charger les personnages
  }

  Future<void> fetchSaisons() async {
    final data = await ApiService.getSaisons();
    setState(() {
      saisons = data.map((s) => {"id": s.id, "titre": s.titre}).toList();
      if (saisons.isNotEmpty && selectedSaisonId == null) {
        selectedSaisonId = saisons[0]['id'];
      }
    });
  }

  Future<void> fetchPersonnages() async {
    final data = await ApiService.getPersonnages();
    setState(() {
      allPersonnages = data;
    });
  }

  Future<void> createSaison() async {
    if (_formSaisonKey.currentState!.validate()) {
      await ApiService.createSaison(saisonTitreController.text);
      setState(() {
        messageSaison = "Saison créée avec succès !";
        saisonTitreController.clear();
      });
      await fetchSaisons();
    }
  }

  Future<void> createEpisode() async {
    if (_formEpisodeKey.currentState!.validate() && selectedSaisonId != null) {
      final episodeId = await ApiService.createEpisode(
        titre: episodeTitreController.text,
        resume: episodeResumeController.text,
        numero: int.tryParse(episodeNumeroController.text) ?? 1,
        image: episodeImageController.text,
        saisonId: selectedSaisonId!,
      );

      // Associer les personnages sélectionnés à l’épisode créé
      if (selectedPersonnagesIds.isNotEmpty) {
        await ApiService.addPersonnagesToEpisode(episodeId, selectedPersonnagesIds);
      }

      setState(() {
        messageEpisode = "Épisode créé avec succès !";
        episodeTitreController.clear();
        episodeResumeController.clear();
        episodeNumeroController.clear();
        episodeImageController.clear();
        selectedPersonnagesIds.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Création Saison & Épisode')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulaire création saison
            Form(
              key: _formSaisonKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Créer une saison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: saisonTitreController,
                    decoration: const InputDecoration(labelText: 'Titre de la saison'),
                    validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un titre' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: createSaison,
                    child: const Text('Ajouter la saison'),
                  ),
                  const SizedBox(height: 5),
                  Text(messageSaison, style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Formulaire création épisode
            Form(
              key: _formEpisodeKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Créer un épisode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: episodeTitreController,
                    decoration: const InputDecoration(labelText: 'Titre de l\'épisode'),
                    validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un titre' : null,
                  ),
                  TextFormField(
                    controller: episodeResumeController,
                    decoration: const InputDecoration(labelText: 'Résumé'),
                    validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un résumé' : null,
                  ),
                  TextFormField(
                    controller: episodeNumeroController,
                    decoration: const InputDecoration(labelText: 'Numéro'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un numéro' : null,
                  ),
                  TextFormField(
                    controller: episodeImageController,
                    decoration: const InputDecoration(labelText: 'URL de l\'image'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedSaisonId,
                    decoration: const InputDecoration(labelText: 'Saison'),
                    items: saisons.map((s) {
                      return DropdownMenuItem<String>(
                        value: s['id'],
                        child: Text(s['titre']),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSaisonId = val;
                      });
                    },
                    validator: (value) => value == null ? 'Veuillez sélectionner une saison' : null,
                  ),
                  const SizedBox(height: 20),
                  // Multi-select personnages
                  const Text('Sélectionner les personnages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Wrap(
                    children: allPersonnages.map((p) {
                      final isSelected = selectedPersonnagesIds.contains(p.id);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: FilterChip(
                          label: Text(p.nom),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedPersonnagesIds.add(p.id);
                              } else {
                                selectedPersonnagesIds.remove(p.id);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: createEpisode,
                    child: const Text('Ajouter l\'épisode'),
                  ),
                  const SizedBox(height: 5),
                  Text(messageEpisode, style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}