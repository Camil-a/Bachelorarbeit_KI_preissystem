import os
from flask import Blueprint, request, jsonify
from flask import send_from_directory

from joblib import load
import pandas as pd
from recommendsystem.hybrid_filter import recommend_contentbased_by_models, get_cars, data, feature_Model,cosine_sim, set_cars



filter_bp = Blueprint("filter", __name__)

model_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/my_model.joblib')

filter_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/contentbased_by_mode.joblib')

modelconfig_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/config.joblib')

#IMAGE_ROOT ist der Ordner, in dem alle Unterordner wie A25, A17 usw. liegen.
IMAGE_ROOT = os.path.join(os.path.dirname(__file__), "../Data/usecar_image")  # Pfad anpassen



@filter_bp.route("/cars", methods=["GET"])
def cars_api():
    cars= get_cars()
    return jsonify(cars)


# Diese Methode dient dazu, Bilddateien vom Server bereitzustellen, damit sie über eine.
# URL im Browser, in Flutter oder in einer App geladen werden können.
@filter_bp.route("/usecar_image/<folder>/<filename>")
def serve_car_image(folder, filename):

    #Build the real folder patn on your computer
    folder_path = os.path.join(IMAGE_ROOT, folder)

    #Flask sends the image file back to the client.
    return send_from_directory(folder_path, filename)

# @filter_bp.route("/recommend/<model_name>", methods=["GET"])
# def recommend():
 
#     results = recommend_contentbased_by_models(model_name)

#     #return jsonify(results)
#     return jsonify(results.to_dict(orient="records"))

@filter_bp.route("/recommend", methods=["GET"])
@filter_bp.route("/recommend/<model_name>", methods=["GET"])
def recommend(model_name=None):
    if not model_name:
        model_name = request.args.get("model")
    if not model_name:
        return jsonify({"error": "No model specified"}), 400

    results = recommend_contentbased_by_models(model_name)
    
    return jsonify(results)

    #return jsonify(results.to_dict(orient="records"))


# @filter_bp.route("/recommend", methods=["GET"])
# def recommend():
#     model_name = request.args.get("model")  # Query-Parameter 'model'
#     if not model_name:
#         return jsonify({"error": "No model specified"}), 400

#     results = recommend_contentbased_by_models(model_name)
#     return jsonify(results.to_dict(orient="records"))


    







# #@filter_bp.route('/recommend_content', methods=['GET'])
# def recommend_content():
#     #model_name = request.args.get('model')

#     try:
#         result =recommend_contentbased_by_model('Focus')
              
#         if result.empty:
#             return jsonify({"error": "Kein Ergebnis gefunden"}), 404

#         # Nur relevante Spalten auswählen
#         result = result[[
#             "Brand",
#             "Model",
#             "year_of_manufacture",
#             "Mileage",
#             "Fueltype",
#             "Sale price",
#             "images"
#         ]]

#         return jsonify(result.to_dict(orient="records"))

#     except Exception as e:
#         return jsonify({"error": str(e)}), 500

# #recommend_content()

