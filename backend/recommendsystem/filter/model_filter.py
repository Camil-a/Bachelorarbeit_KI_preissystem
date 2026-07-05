from recommendsystem.hybrid_filter import  data, feature_Model,cosine_sim, cosine_sim_item,set_cars
import pandas as pd



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


def recommend_collaborative_by_models(model_name, top_n=20):

    try:    # Prüfen, ob das Modell im Datensatz existiert
        if model_name not in data[feature_Model].astype(str).values:
             raise ValueError(f"Modell '{model_name}' nicht im Datensatz gefunden.")
       

        # Index des Autos anhand des Modellnamens
        car_index = data.index[data[feature_Model] == model_name][0]

        # Cosinus-Ähnlichkeitswerte für das Auto
        similarity_scores = list(enumerate(cosine_sim_item[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]

        recommended_car = data.iloc[similar_indices]

        return set_cars(recommended_car)

    except ValueError as e:
        print(e)
        return []
    

    
def recommend_hybrid_by_model(model_name, top_n=20, alpha=0.5):
    """
    Hybrid Recommendation

    model_name : Name des Automodells
    top_n      : Anzahl Empfehlungen
    alpha      : Gewicht für Collaborative Filtering
                 (1-alpha) = Gewicht für Content-Based
    """

    try:
        # prüfen ob Modell existiert
        if model_name not in data[feature_Model].astype(str).values:
            raise ValueError(f"Modell '{model_name}' nicht im Datensatz gefunden.")

        # item_id des Autos holen
        car_id = data.loc[data[feature_Model] == model_name, 'item_id'].values[0]

        # Content-Based Scores
        content_scores = pd.DataFrame({
            'item_id': range(len(cosine_sim[car_id])),
            'content_score': cosine_sim[car_id]
        })

        # Collaborative Scores
        collaborative_scores = pd.DataFrame({
            'item_id': range(len(cosine_sim_item[car_id])),
            'collab_score': cosine_sim_item[car_id]
        })

        # Scores zusammenführen
        hybrid = pd.merge(content_scores, collaborative_scores, on='item_id')

        # Hybrid Score berechnen
        hybrid['hybrid_score'] = (
            (1 - alpha) * hybrid['content_score'] +
            alpha * hybrid['collab_score']
        )

        # eigenes Auto entfernen
        hybrid = hybrid[hybrid['item_id'] != car_id]

        # sortieren
        hybrid = hybrid.sort_values(by='hybrid_score', ascending=False)

        # Top N auswählen
        top_items = hybrid.head(top_n)['item_id']

        recommended_cars = data[data['item_id'].isin(top_items)]

        return set_cars(recommended_cars)

    except ValueError as e:
        print(e)
        return []  


    
      