import random
from pymongo import MongoClient
from bson import ObjectId

# Connexion à la base MongoDB locale
client = MongoClient("mongodb://localhost:27017/")
db = client.simpsonhub

# Liste des épisodes valides (les IDs MongoDB que tu m'as fournis)
valid_episode_ids = [
    ObjectId("683725b651f9f2f20e406709"),
    ObjectId("6837277e51f9f2f20e40670f"),
    ObjectId("6837278751f9f2f20e406711"),
    ObjectId("683728a551f9f2f20e406719"),
    ObjectId("683728b551f9f2f20e40671b"),
    ObjectId("683728c051f9f2f20e40671d"),
    ObjectId("683728f851f9f2f20e40671f"),
    ObjectId("6837290351f9f2f20e406721"),
    ObjectId("6837290d51f9f2f20e406723"),
]

def clean_personnage_episodes():
    personnages = list(db.personnages.find())
    print(f"Nombre de personnages à traiter : {len(personnages)}")

    for p in personnages:
        current_episodes = p.get("episodes", [])
        # Garder uniquement les épisodes valides
        valid_episodes = [ep for ep in current_episodes if ep in valid_episode_ids]

        # Si la liste d'épisodes valides est vide, on ajoute 1 ou 2 épisodes aléatoires
        if not valid_episodes:
            valid_episodes = random.sample(valid_episode_ids, k=random.randint(1,2))
        else:
            # Pour chaque épisode non valide, on remplace par un aléatoire
            invalid_episodes_count = len(current_episodes) - len(valid_episodes)
            for _ in range(invalid_episodes_count):
                valid_episodes.append(random.choice(valid_episode_ids))

        # Supprimer les doublons
        valid_episodes = list(set(valid_episodes))

        # Mise à jour du personnage
        db.personnages.update_one(
            {"_id": p["_id"]},
            {"$set": {"episodes": valid_episodes}}
        )
        print(f"Personnage '{p.get('nom')}' mis à jour avec {len(valid_episodes)} épisodes.")

if __name__ == "__main__":
    clean_personnage_episodes()
    print("Mise à jour terminée.")