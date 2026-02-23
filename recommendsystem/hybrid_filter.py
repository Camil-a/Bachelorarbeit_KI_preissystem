

import os,cv2
from joblib import load
import pandas as pd
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles



fastAPI = FastAPI()
fastAPI.mount("/images", StaticFiles(directory="Data/usecar_image"), name="images")




feature_Model='Model'
feature_price='Sale price'


# load Cosine Similarity Matrix
cosine_sim_path = os.path.join(os.path.dirname(__file__), 'cosine_similarity.joblib')

# load DataFrame
dataFrame_path = os.path.join(os.path.dirname(__file__), 'dataFrame.joblib')

data = load(dataFrame_path)
cosine_sim=load(cosine_sim_path)

print("Existiert Datei cosinuspath?", os.path.exists(cosine_sim_path))



base_image_dir = "Data/usecar_image"
base_image_dir = os.path.join(os.path.dirname(__file__), "../Data/usecar_image")

IMAGE_ROOT = os.path.join(os.path.dirname(__file__), "../Data/usecar_image")  # Pfad anpassen
#print("Existiert Datei IMAGE._ROOT?---------------------------------------------------", os.path.exists(IMAGE_ROOT))



# Neue Spalte für Bilder
data['images'] 
      
def set_cars(data):
    cars = []

    for idx, row in data.iterrows():
        folder_name = row["images"]
       
        image_urls = [
            f"http://localhost:5000/usecar_image/{folder_name}/{os.path.basename(img)}"
            for img in row["image_files"]
        ]

        cars.append({
            "brand": row["Brand"],
            "model": row["Model"],
            "fueltype": row["Fueltype"],
            "item_id": int(row["item_id"]),
            "Sale_price": float(row["Sale price"]),
            "next_TUV": (row["nextTUV"]),
            "mileage": float(row["Mileage"]),
            "engine_power": int(row["Engine_power(kilowatt)"]),
            "images": image_urls
        })

    return cars


def save_image_to_folder_in_data(base_image_dir):
    # alle Ordner durchlaufen
    for root, dirs, files in os.walk(base_image_dir):
        
        #lists all files 
        folder_name = os.path.basename(root)   
        
        # prüfen ob Ordnername im DataFrame existiert
        if folder_name in data['images'].values:
            
            # Collect images in the folder
            images = [os.path.join(root, f) for f in files
                    if f.lower().endswith((".png", ".jpg", ".jpeg"))]
            
            # passende Zeile finden und speichern
            # passende Zeilen holen
            matching_rows = data.index[data['images'] == folder_name]

            for idx in matching_rows:
                data.at[idx, 'image_files'] = images
    #print(data)

save_image_to_folder_in_data(base_image_dir)
    
def recommend_contentbased_by_models(model_name, top_n=5):

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
    
print('--------Recommd----------')
print(recommend_contentbased_by_models('Focus'))
    

def recommend_similar_cars_by_price(price, top_n=10):
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
                f"http://localhost:5000/usecar_image/{folder_name}/{os.path.basename(img)}"
                for img in row["image_files"]
            ]

            cars.append({
            "brand": row["Brand"],
            "model": row["Model"],
            "item_id": int(row["item_id"]),
            "Sale_price": float(row["Sale price"]),
            "next_TUV": (row["nextTUV"]),
            "images": image_urls
        })

    return cars



#print(get_cars())


























    
