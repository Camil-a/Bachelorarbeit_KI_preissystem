from recommendsystem.hybrid_filter import  data, feature_milleage,cosine_sim, cosine_sim_item,set_cars
import pandas as pd


def recommend_contentbased_by_milleage(km, top_n=10):
    try:
        # Prüfen, ob mindestens ein Auto mit dem Kilometerstand existiert
        if km not in data[feature_milleage].values:
            # Falls exakter Kilometerstand nicht existiert, nächstgelegenen Wert nehmen
            closest_km = data[feature_milleage].iloc[(data[feature_milleage] - km).abs().argsort()[0]]
            print(f"Kein Auto mit {km} km gefunden. Nächstgelegener Kilometerstand: {closest_km}")
            km = closest_km

        # Index des Autos mit dem Kilometerstand
        car_index = data.index[data[feature_milleage] == km][0]

        # Cosinus-Ähnlichkeitswerte für das Auto
        similarity_scores = list(enumerate(cosine_sim[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]

        return set_cars(data.iloc[similar_indices])

    except Exception as e:
        print(f"Fehler: {e}")
        return []


def recommend_collaborative_by_milleage(km, top_n=10):
    try:
        # Prüfen, ob mindestens ein Auto mit dem Kilometerstand existiert
        if km not in data[feature_milleage].values:
            # Falls exakter Kilometerstand nicht existiert, nächstgelegenen Wert nehmen
            closest_km = data[feature_milleage].iloc[(data[feature_milleage] - km).abs().argsort()[0]]
            print(f"Kein Auto mit {km} km gefunden. Nächstgelegener Kilometerstand: {closest_km}")
            km = closest_km

        # Index des Autos mit dem Kilometerstand
        car_index = data.index[data[feature_milleage] == km][0]

        # Cosinus-Ähnlichkeitswerte für das Auto
        similarity_scores = list(enumerate(cosine_sim_item[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]

        return set_cars(data.iloc[similar_indices])

    except Exception as e:
        print(f"Fehler: {e}")
        return []



    
def recommend_hybrid_by_milleage(km, top_n=5, alpha=0.5):
    """
    Hybrid Recommendation

    km : Kilometerstand des Autos
    top_n      : Anzahl Empfehlungen
    alpha      : Gewicht für Collaborative Filtering
                 (1-alpha) = Gewicht für Content-Based
    """

    try:
        # prüfen ob Kilometerstand existiert
        if km not in data[feature_milleage].values:
            closest_km = data[feature_milleage].iloc[(data[feature_milleage] - km).abs().argsort()[0]]
            print(f"Kein Auto mit {km} km gefunden. Nächstgelegener Kilometerstand: {closest_km}")
            km = closest_km


        # item_id des Autos holen
        car_id = data.loc[data[feature_milleage] == km, 'item_id'].values[0]

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