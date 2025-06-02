import random
from pymongo import MongoClient
from bson import ObjectId

# Connexion à MongoDB locale
client = MongoClient("mongodb://localhost:27017/")
db = client.simpsonhub

# Liste des épisodes valides (IDs que tu m'as fournis)
valid_episode_ids = [
    ObjectId("683725b651f9f2f20e406709"),  # Bart le génie
    ObjectId("6837277e51f9f2f20e40670f"),  # Une soirée d’enfer
    ObjectId("6837278751f9f2f20e406711"),  # L’odyssée d’Homer
    ObjectId("683728a551f9f2f20e406719"),  # La famille s'agrandit
    ObjectId("683728b551f9f2f20e40671b"),  # Le cauchemar de Bart
    ObjectId("683728c051f9f2f20e40671d"),  # Lisa la rebelle
    ObjectId("683728f851f9f2f20e40671f"),  # Homer détective
    ObjectId("6837290351f9f2f20e406721"),  # Maggie fait des siennes
    ObjectId("6837290d51f9f2f20e406723"),  # L'anniversaire de Marge
]

def assign_min_episodes_to_personnages(min_episodes=2):
    personnages = list(db.personnages.find())
    print(f"Total personnages : {len(personnages)}")
    for p in personnages:
        current_episodes = p.get('episodes', [])
        current_count = len(current_episodes)
        if current_count < min_episodes:
            needed = min_episodes - current_count
            # Choisir des épisodes aléatoires non encore assignés à ce personnage
            available = list(set(valid_episode_ids) - set(current_episodes))
            chosen = random.sample(available, min(needed, len(available)))
            new_episodes = current_episodes + chosen
            db.personnages.update_one(
                {'_id': p['_id']},
                {'$set': {'episodes': new_episodes}}
            )
            print(f"Personnage '{p['nom']}' avait {current_count} épisodes. Ajouté {len(chosen)} épisodes.")
        else:
            print(f"Personnage '{p['nom']}' a déjà {current_count} épisodes.")

def ensure_episodes_have_personnages():
    print("Vérification que chaque épisode a au moins un personnage associé...")
    for ep_id in valid_episode_ids:
        personnages = list(db.personnages.find({'episodes': ep_id}))
        if not personnages:
            # Choisir un personnage aléatoire pour cet épisode
            personnage = db.personnages.aggregate([{'$sample': {'size': 1}}]).next()
            db.personnages.update_one(
                {'_id': personnage['_id']},
                {'$addToSet': {'episodes': ep_id}}
            )
            print(f"Ajouté épisode {ep_id} au personnage {personnage['nom']} (aucun personnage associé avant).")
        else:
            print(f"Épisode {ep_id} a déjà {len(personnages)} personnage(s).")

if __name__ == "__main__":
    assign_min_episodes_to_personnages(min_episodes=2)
    ensure_episodes_have_personnages()
    print("Mise à jour terminée.")