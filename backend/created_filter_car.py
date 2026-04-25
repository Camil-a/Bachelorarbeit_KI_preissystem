import os
from flask import Blueprint, request, jsonify
from flask import send_from_directory

from joblib import load
import pandas as pd
from recommendsystem.hybrid_filter import  get_cars
from recommendsystem.filter.model_filter import recommend_hybrid_by_model
from recommendsystem.filter.price_filter import recommend_hybrid_by_budget, recommend_hybrid_by_price

filter_bp = Blueprint("filter", __name__)


# model_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/my_model.joblib')

# filter_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/contentbased_by_mode.joblib')

# modelconfig_path = os.path.join(os.path.dirname(__file__), '../recommendsystem/config.joblib')

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




@filter_bp.route("/recommend", methods=["GET"])
@filter_bp.route("/recommend/<model_name>", methods=["GET"])
def recommend(model_name=None):
    if not model_name:
        model_name = request.args.get("model")
    if not model_name:
        return jsonify({"error": "No model specified"}), 400

    #results = recommend_contentbased_by_models(model_name)
    results = recommend_hybrid_by_model(model_name)
    return jsonify(results)

@filter_bp.route("/recommend_price", methods=["GET"])
@filter_bp.route("/recommend_price/<sale_price>", methods=["GET"])
def recommend_by_price( sale_price=None):
    if not sale_price:
        sale_price = request.args.get("sale_price")
    if not sale_price:
        return jsonify({"error": "No sale price specified"}), 400

    #results = recommend_contentbased_by_models(model_name)
    results = recommend_hybrid_by_budget(sale_price)
    return jsonify(results)





    








