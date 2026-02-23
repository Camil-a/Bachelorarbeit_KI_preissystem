from flask import Flask, request, jsonify
from flask_cors import CORS
from joblib import load
import pandas as pd

app = Flask(__name__)
CORS(app)

# ====== Modell laden (einmal global) ======
# Dein trainiertes Pipeline-Modell mit Preprocessing
model = load("car_price_pipeline.pkl")

# ====== Prediction Endpoint ======
@app.route("/predict_price", methods=["POST"])
def predict_price():
    try:
        data = request.get_json()

        # ====== Features extrahieren ======
        technic = data.get("technic", {})
        optical = data.get("optical", {})
       

        # Beispiel: numerische Features
        mileage = float(technic.get("mileage", 0))
        ps = float(technic2.get("ps", 0))
        tankCapacity = float(technic2.get("tankCapacity", 0))
        cubicCapacity = float(technic2.get("cubicCapacity", 0))
        emptyWeight = float(technic2.get("emptyWeight", 0))
        maxSpeed = float(technic2.get("maxSpeed", 0))

        # Strings/Boolean Features
        brand = technic.get("brand", "")
        model_car = technic.get("model", "")
        year = int(technic.get("year", 2000))
        engineType = technic.get("engine_type", "")
        bodyStyle = technic.get("Body_Style", "")
        transmissionType = technic.get("transmission_Type", "")
        isLeasingCar = 1 if technic.get("isLeasingCar", "No").lower() == "yes" else 0

        # Datum → numerisch für ML
        nextTuvYear = int(technic.get("next_TUV_Year", 2023))
        nextTuvMonate = int(technic.get("next_TUV_Monate", 1))
        nextTuvDay = int(technic.get("next_TUV_Day", 1))
        nextTuv_numeric = nextTuvYear*10000 + nextTuvMonate*100 + nextTuvDay

        # Optional: zusätzliche Features aus optical, optical1, falls dein Modell sie nutzt
        # z.B. Schäden als 0/1
        damagedLinkDoor = 1 if optical.get("damagedLink_Door", "No").lower() == "yes" else 0
        damagedRightDoor = 1 if optical.get("damagedRight_Door", "No").lower() == "yes" else 0
        damagedMirror = 1 if optical.get("damaged_Mirror", "No").lower() == "yes" else 0

        # ====== DataFrame für Pipeline ======
        features_dict = {
            "mileage": mileage,
            "ps": ps,
            "tankCapacity": tankCapacity,
            "cubicCapacity": cubicCapacity,
            "emptyWeight": emptyWeight,
            "maxSpeed": maxSpeed,
            "brand": brand,
            "model": model_car,
            "year": year,
            "engineType": engineType,
            "bodyStyle": bodyStyle,
            "transmissionType": transmissionType,
            "isLeasingCar": isLeasingCar,
            "nextTuv": nextTuv_numeric,
            "damagedLinkDoor": damagedLinkDoor,
            "damagedRightDoor": damagedRightDoor,
            "damagedMirror": damagedMirror
        }

        features_df = pd.DataFrame([features_dict])

        # ====== Preis vorhersagen ======
        predicted_price = model.predict(features_df)[0]

        return jsonify({
            "status": "success",
            "predicted_price": round(float(predicted_price), 2)
        })

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        })



