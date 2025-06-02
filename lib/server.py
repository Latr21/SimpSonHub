from fastapi import FastAPI
from pymongo import MongoClient
from bson import ObjectId
from fastapi.middleware.cors import CORSMiddleware
from fastapi import Request
from fastapi import HTTPException
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles

app = FastAPI()
app.mount("/images", StaticFiles(directory="lib/asset"), name="images")
def convert_doc(doc):
    # Convertit un document MongoDB en dict JSON-serializable
    if not doc:
        return None
    doc = dict(doc)
    # Convert _id si présent
    if '_id' in doc and isinstance(doc['_id'], ObjectId):
        doc['_id'] = str(doc['_id'])
    # Si d'autres champs sont des ObjectId (ex: saison_id, personnages_ids), convertis-les aussi
    for key, value in doc.items():
        if isinstance(value, ObjectId):
            doc[key] = str(value)
        # Si c'est une liste d'ObjectId, convertis chaque élément
        elif isinstance(value, list):
            doc[key] = [str(v) if isinstance(v, ObjectId) else v for v in value]
    return doc
# Autoriser toutes les origines pour le test (à sécuriser plus tard)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Connexion MongoDB sans .env
client = MongoClient("mongodb://localhost:27017/")
db = client["simpsonhub"]

# Accueil
@app.get("/")
def accueil():
    return {"message": "API FastAPI connectée à MongoDB"}

# Obtenir tous les épisodes
@app.get("/episodes")
def get_episodes():
    episodes = list(db.episodes.find())
    for e in episodes:
        e["_id"] = str(e["_id"])
        e["saison_id"] = str(e["saison_id"])
    return episodes
# Obtenir un épisode par son ID
@app.get("/episodes/{episode_id}")
def get_episode_by_id(episode_id: str):
    episode = db.episodes.find_one({"_id": ObjectId(episode_id)})
    if not episode:
        return {"error": "Episode non trouvé"}
    episode["_id"] = str(episode["_id"])
    episode["saison_id"] = str(episode["saison_id"])
    return episode
# Obtenir tous les personnages
@app.get("/personnages")
def get_personnages():
    personnages = list(db.personnages.find())
    for p in personnages:
        p["_id"] = str(p["_id"])
        p["episodes"] = [str(e) for e in p.get("episodes", [])]
    return personnages

# Obtenir les épisodes associés à un personnage donné
@app.get("/personnages/{personnage_id}/episodes")
def get_episodes_by_personnage(personnage_id: str):
    personnage = db.personnages.find_one({"_id": ObjectId(personnage_id)})
    if not personnage:
        return {"error": "Personnage non trouvé"}

    episode_ids = personnage.get("episodes", [])
    object_ids = [ObjectId(eid) for eid in episode_ids]

    episodes = list(db.episodes.find({"_id": {"$in": object_ids}}))

    # Utilise convert_doc sur chaque document avant de retourner
    return [convert_doc(e) for e in episodes]

# Obtenir les épisodes d'une saison spécifique
@app.get("/saisons/{saison_id}/episodes")
async def get_episodes(saison_id: str):
    episodes = list(db.episodes.find({"saison_id": ObjectId(saison_id)}))
    return [convert_doc(ep) for ep in episodes]  # Convertis chaque document
# Obtenir toutes les saisons
@app.get("/saisons")
def get_saisons():
    saisons = list(db.saisons.find())
    for s in saisons:
        s["_id"] = str(s["_id"])
    return saisons



# Obtenir les personnages associés à un épisode donné
@app.post("/episodes/{episode_id}/personnages")
async def add_personnages_to_episode(episode_id: str, request: Request):
    data = await request.json()
    personnages_ids = data.get("personnages_ids", [])

    if not personnages_ids:
        return JSONResponse({"error": "Liste de personnages vide"}, status_code=400)

    # Convertir les ids en ObjectId
    object_ids = [ObjectId(pid) if not isinstance(pid, ObjectId) else pid for pid in personnages_ids]

    # Mettre à jour l'épisode en ajoutant les personnages sans écraser la liste existante
    db.episodes.update_one(
        {"_id": ObjectId(episode_id)},
        {"$addToSet": {"personnages": {"$each": object_ids}}}
    )
    return {"message": "Personnages ajoutés à l'épisode"}

@app.get("/episodes/{episode_id}/complete")
def get_episode_complete(episode_id: str):
    episode = db.episodes.find_one({"_id": ObjectId(episode_id)})
    if not episode:
        return {"error": "Episode non trouvé"}
    episode["_id"] = str(episode["_id"])
    episode["saison_id"] = str(episode["saison_id"])

    # Récupérer la liste d'IDs personnages depuis l'épisode
    personnages_ids = episode.get("personnages", [])

    # Convertir en ObjectId si ce ne sont pas déjà des ObjectId
    object_ids = [ObjectId(pid) if not isinstance(pid, ObjectId) else pid for pid in personnages_ids]

    # Rechercher les personnages dont l'ID est dans la liste
    personnages = list(db.personnages.find({"_id": {"$in": object_ids}}))

    for p in personnages:
        p["_id"] = str(p["_id"])
        p["episodes"] = [str(e) for e in p.get("episodes", [])]

    episode["personnages"] = personnages
    return episode


@app.post("/login")
async def login(request: Request):
    data = await request.json()
    email = data.get("email")
    password = data.get("password")
    if not email or not password:
        return {"error": "Email et mot de passe requis"}
    db_user = db.users.find_one({"email": email, "password": password})
    if db_user:
        return {"success": True}
    else:
        return {"success": False}
    
    
@app.post("/saisons")
async def create_saison(request: Request):
    data = await request.json()
    titre = data.get("titre")
    if not titre:
        raise HTTPException(status_code=400, detail="Titre requis")

    # Récupérer la saison avec le numéro le plus élevé
    last_saison = db.saisons.find_one(sort=[("numero", -1)])

    # Calculer le nouveau numéro : si aucune saison, commencer à 1
    nouveau_numero = last_saison["numero"] + 1 if last_saison and "numero" in last_saison else 1

    nouvelle_saison = {
        "titre": titre,
        "numero": nouveau_numero,
    }

    result = db.saisons.insert_one(nouvelle_saison)
    return {
        "_id": str(result.inserted_id),
        "titre": titre,
        "numero": nouveau_numero,
    }

@app.post("/episodes")
async def create_episode(request: Request):
    data = await request.json()
    titre = data.get("titre")
    resume = data.get("resume")
    numero = data.get("numero")
    image = data.get("image")
    saison_id = data.get("saison_id")

    if not (titre and resume and numero and saison_id):
        return JSONResponse({"error": "Champs manquants"}, status_code=400)

    episode_doc = {
        "titre": titre,
        "resume": resume,
        "numero": numero,
        "image": image,
        "saison_id": ObjectId(saison_id),
        "personnages": []  # Liste vide au départ
    }

    result = db.episodes.insert_one(episode_doc)
    return {"_id": str(result.inserted_id)}

