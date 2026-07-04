from flask import Flask
from backend.formular import form_bp  # Import the blueprint from the module where it's defined
from flask_cors import CORS
from backend.server import filter_bp


app = Flask(__name__)
CORS(app)

# Save Blueprint 
app.register_blueprint(form_bp)
app.register_blueprint(filter_bp)


if __name__ == "__main__":
    print("Flask Backend läuft auf http://localhost:5001/submit_form")
    print("Flask Backend läuft auf http://localhost:5001/cars")
    print("Flask Backend läuft auf http://localhost:5001/recommend")



    print('Hallo')

    app.run(host="0.0.0.0", debug=True, port=5001)

