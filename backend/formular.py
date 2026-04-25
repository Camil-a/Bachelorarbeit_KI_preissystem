import os
from flask import Blueprint, request, jsonify
import numpy as np
import pickle
from joblib import load
import pandas as pd





form_bp = Blueprint("form", __name__)
data=0



#model_path = os.path.join(os.path.dirname(__file__), '../5-modelling/model_linear.joblib')
model_path = os.path.join(os.path.dirname(__file__), '../5-modelling/model_xGboox.joblib')

# Load the trained linear regression model
with open(model_path, 'rb') as f:
   model_LineareRegression = load(f)
print("Existiert Datei?", os.path.exists(model_path))


@form_bp.route("/submit_form", methods=[ "POST"])
def submit_form():

    data = request.json  # JSON-Daten vom Flutter-Formular
    #  technic data  
    technic = data["technic"]
    
    #Damage data
    damaged = data["damaged"]


    'Create a dictionary with the features for prediction'
    features_dict = {
        'Brand': technic["Brand"],  # Leerzeichen beachten
        'Model': technic["Model"],
        'year_of_manufacture': technic["year_of_manufacture"],
        'Engine_power(kilowatt)': technic["Engine_power(kilowatt)"],
        'Engine_power_(Horsepower)': technic["Engine_power_(Horsepower)"],
        'Transmission_type': technic["Transmission_type"],
        'Mileage': technic["Mileage"],
        'Fueltype': technic["Fueltype"],
        'days_to_TUV': technic["nextTUV"],
        'Nber_previous_owners': int(technic.get("Nber_previous_owners") or 0),
        'Body_style': technic["Body_style"],
        'Tire_type': technic["Tire_type"],
        'Accident_history': technic["Accident_history"],
        'damaged_front': damaged["damaged_front"],
        'damaged_rear': damaged["damaged_rear"],
        'damaged_left_side': damaged["damaged_left_side"],
        'damaged_right_side': damaged["damaged_right_side"],
        'damaged_interior': damaged["damaged_interior"],
        'damaged_exterior': damaged["damaged_exterior"],
        'damaged_tire': damaged["damaged_tire"],
        'damaged_rim': damaged["damaged_rim"],
        'damaged_roof_beam': damaged["damaged_roof_beam"],
        'damaged_left_door': damaged["damaged_left_door"],
        'damaged_right_door': damaged["damaged_right_door"],
        'damaged_seats': damaged["damaged_seats"],
        'interior_dirty': damaged["interior_dirty"],
        'damaged_carosserie': damaged["damaged_carosserie"],
        'images':'no image'

    }

     
    'Convert the features dictionary to a DataFrame for prediction'
    features_df = pd.DataFrame([features_dict])
    print("---------------------------------")
    print("Features DataFrame:\n", features_df)

    'Make the price prediction using the loaded model'
    price = model_LineareRegression.predict(features_df)[0]
    print("Predicted price:", price)

    return jsonify({
        "status": "success",
        "message": "Form received!",
        "predicted_price": round(float(price), 2)

          })



