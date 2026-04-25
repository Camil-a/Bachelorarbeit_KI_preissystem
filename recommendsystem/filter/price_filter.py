from recommendsystem.hybrid_filter import  data, feature_price,cosine_sim, cosine_sim_item,set_cars
import pandas as pd




def recommend_contentbased_cars_by_price(price, top_n=10):
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
    

    
def recommend_collaborative_cars_by_price(price, top_n=10):
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
        similarity_scores = list(enumerate(cosine_sim_item[car_index]))

        # Sortieren nach Ähnlichkeit absteigend
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Indizes der Top-N ähnlichen Autos (ohne das Auto selbst)
        similar_indices = [i for i, _ in similarity_scores[1:top_n+1]]
        
        recomend_car_by_price=data.iloc[similar_indices]
        return set_cars(recomend_car_by_price)

    except Exception as e:
        print(f"Fehler: {e}")
        return []  # Leere DataFrame zurückgeben
    


# User gibt Budget (z. B. 25.000 €)
# Wir filtern Autos im Budget-Bereich
# Für jedes gefilterte Auto berechnen wir Hybrid-Score
# Zusätzlich berücksichtigen wir Preisnähe
# Sortieren nach Gesamtscore
    
def recommend_hybrid_by_budget(budget, top_n=20, alpha=0.5, price_weight=0.2):
    """
    Hybrid Recommendation mit Budget

    budget        : verfügbares Budget
    top_n         : Anzahl Empfehlungen
    alpha         : Gewicht Collaborative (0-1)
    price_weight  : Gewicht Preisnähe im Ranking
    """

    try:
         # Budget sicher als float
        budget = float(budget)
        #  Autos innerhalb Budget (z.B. +/- 20%)
        lower_bound = budget * 0.8
        upper_bound = budget * 2.2

        budget_cars = data[
            (data['Sale price'] >= lower_bound) &
            (data['Sale price'] <= upper_bound)
        ].copy()

        if budget_cars.empty:
            print("Keine Autos im Budgetbereich gefunden.")
            return []

        results = []

        # Für jedes Auto im Budget Hybrid Score berechnen
        for _, row in budget_cars.iterrows():
            car_id = row['item_id']

            content_score = cosine_sim[car_id].mean()
            collab_score = cosine_sim_item[car_id].mean()

            hybrid_score = (
                (1 - alpha) * content_score +
                alpha * collab_score
            )

            # Preisnähe berechnen (je näher am Budget, desto besser)
            price_score = 1 - abs(row['Sale price'] - budget) / budget

            # Finaler Score
            final_score = hybrid_score + price_weight * price_score

            results.append((car_id, final_score))

        # Sortieren
        results = sorted(results, key=lambda x: x[1], reverse=True)

        top_items = [car_id for car_id, _ in results[:top_n]]

        recommended_cars = data[data['item_id'].isin(top_items)]

        return set_cars(recommended_cars)

    except ValueError as e:
        print(e)
        return []



def recommend_hybrid_by_price(price, top_n=20, alpha=0.5):
    """
    Hybrid Recommendation

    price_weight : Gewicht Preisnähne im Ranking
    top_n      : Anzahl Empfehlungen
    alpha      : Gewicht für Collaborative (0-1)
                 (1-alpha) = Gewicht für Content-Based
    """

    try:
        # prüfen ob Preis existiert
        if price not in data[feature_price].values:
            raise ValueError(f"Preis '{price}' nicht im Datensatz gefunden.")

        # item_id des Autos holen
        car_id = data.loc[data[feature_price] == price, 'item_id'].values[0]

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