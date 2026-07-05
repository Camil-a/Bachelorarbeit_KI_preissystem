

import os
from joblib import load
import pandas as pd
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles



fastAPI = FastAPI()
fastAPI.mount("/images", StaticFiles(directory="Data/usecar_image"), name="images") # Pfad anpassen, wenn nötig
feature_Model='Model'
feature_price='Sale price'
feature_milleage='Mileage'
# load Cosine Similarity Matrix
cosine_sim_path = os.path.join(os.path.dirname(__file__), 'cosine_similarity.joblib')
cosine_sim_item_path = os.path.join(os.path.dirname(__file__), 'cosine_similarity_collaborativ_filter_item.joblib')

# load DataFrame
dataFrame_path = os.path.join(os.path.dirname(__file__), 'dataFrame.joblib')

data = load(dataFrame_path)
cosine_sim=load(cosine_sim_path)
cosine_sim_item=load(cosine_sim_item_path)

print("Existiert Datei cosinuspath?", os.path.exists(cosine_sim_path))

#base_image_dir = "Data/usecar_image"
base_image_dir = os.path.join(os.path.dirname(__file__), "../Data/usecar_image")

IMAGE_ROOT = os.path.join(os.path.dirname(__file__), "../Data/usecar_image")  # Pfad anpassen
#print("Existiert Datei IMAGE._ROOT?---------------------------------------------------", os.path.exists(IMAGE_ROOT))


def set_cars(data):
    cars = []

    for idx, row in data.iterrows():
        folder_name = row["images"]
        
        image_urls = [
            f"http://localhost:5001/usecar_image/{folder_name}/{os.path.basename(img)}"
            for img in row["image_files"]
        ]
        #print(f"Image URLs for {folder_name}:", image_urls)
        cars.append({
            "brand": row["Brand"],
            "model": row["Model"],
            "fueltype": row["Fueltype"],
            "item_id": int(row["item_id"]),
            "Sale_price": float(row["Sale price"]),
            "next_TUV": (row["days_to_TUV"]),
            "mileage": float(row["Mileage"]),
            "engine_power": int(row["Engine_power(kilowatt)"]),
            "images": image_urls
        })

    return cars



def save_image_to_folder_in_data(base_image_dir):

    # Ensure image_files column exists
    if 'image_files' not in data.columns:
        data['image_files'] = [[] for _ in range(len(data))]
    
    # alle Ordner durchlaufen
    for root, dirs, files in os.walk(base_image_dir):

        #lists all files 
        folder_name = os.path.basename(root)   
        
        # prüfen ob Ordnername im DataFrame existiert
        if folder_name in data['images'].values:
            
            # Collect images in the folder
            images = [os.path.join(root, f) for f in files
                    if f.lower().endswith((".png", ".jpg", ".jpeg"))]
            
            #print(images)
            # passende Zeile finden und speichern
            # passende Zeilen holen
            matching_rows = data.index[data['images'] == folder_name]

            for idx in matching_rows:
                data.at[idx, 'image_files'] = images

    print('--------print image Cars--<<|||||||||||||||||||||||||||||||||--------')
    print(data)

def save_image_to_folder_in_datas(base_image_dir):
    data['image_files'] = [[] for _ in range(len(data))]

    for idx, row in data.iterrows():
        folder_name = str(row["images"]).strip()
        folder_path = os.path.join(base_image_dir, folder_name)

        # check if folder exists
        if os.path.isdir(folder_path):
            images = [
                os.path.join(folder_path, f)
                for f in os.listdir(folder_path)
                if f.lower().endswith((".png", ".jpg", ".jpeg"))
            ]
            data.at[idx, 'image_files'] = images
        else:
            print(f" Folder not found: {folder_path}")    
save_image_to_folder_in_data(IMAGE_ROOT)
    
def recommend_contentbased_by_models(model_name, top_n=20):

    try:    # Prüfen, ob das Modell im Datensatz existiert
        if model_name not in data[feature_Model].astype(str).values:
             raise ValueError(f"Modell '{model_name}' nicht im Datensatz gefunden.")
       

        # Index des Autos anhand des Modellnamens
        car_index = data.index[data[feature_Model] == model_name][0]

        # Cosinus-Ähnlichkeitswerte für das Auto
        similarity_scores = list(enumerate(cosine_sim[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]

        recommended_car = data.iloc[similar_indices]

        return set_cars(recommended_car)

    except ValueError as e:
        print(e)
        return []
    



def recommend_similar_cars_by_price(price, top_n=20):
    try:
        # Prüfen, ob mindestens ein Auto mit dem Preis existiert
        if price not in data[feature_price].values:
            # Falls exakter Preis nicht existiert, nächstgelegenen Preis nehmen
            closest_price = data[feature_price].iloc[(data[feature_price] - price).abs().argsort()[0]]
            print(f"Kein Auto mit Preis {price} gefunden. Nächstgelegener Preis: {closest_price}")
            price = closest_price

        # Index des Autos mit dem Preis
        car_index = data.index[data[feature_price] == price][0]

        # Cosinus-Ähnlichkeitswerte für das Auto
        similarity_scores = list(enumerate(cosine_sim[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]
        
        recomend_car_by_price=data.iloc[similar_indices]
        return set_cars(recomend_car_by_price)

    except Exception as e:
        print(f"Fehler: {e}")
        return []  # Leere DataFrame zurückgeben

# print('--------------PRICE--------------')
# print(   recommend_similar_cars_by_price(6000)
# )


def recommend_by_text(query, top_n=20):
    """Search by model or brand name (partial, case-insensitive)."""
     # change query to lowercase and strip whitespace for better matching
    q = query.lower().strip()

    model_match = data[data['Model'].astype(str).str.lower().str.contains(q, na=False)]
    if not model_match.empty:
        return set_cars(model_match.head(top_n))

    brand_match = data[data['Brand'].astype(str).str.lower().str.contains(q, na=False)]
    if not brand_match.empty:
        return set_cars(brand_match.head(top_n))

    return []


def get_cars():
    cars = []

    # Alle Unterordner durchlaufen, z.B. A1, A2 …
    for folder_name in data['images'].unique():  # assuming 'images' enthält die Ordnernamen
        # Finde alle Zeilen, deren Ordnername == folder_name
        matching_rows = data.index[data['images'] == folder_name]

        for idx in matching_rows:
            row = data.loc[idx]

            # Baue URLs für alle Bilder in dieser Zeile
            image_urls = [
                f"http://localhost:5001/usecar_image/{folder_name}/{os.path.basename(img)}"
                for img in row["image_files"]
            ]

            cars.append({
            "brand": row["Brand"],
            "model": row["Model"],
            "item_id": int(row["item_id"]),
            "Sale_price": float(row["Sale price"]),
            "next_TUV": (row["days_to_TUV"]),
            "images": image_urls
        })

    return cars



























    
