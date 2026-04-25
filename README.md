# Bachelorarbeit – KI-Preissystem für Gebrauchtwagen

A machine learning system for **used car price prediction** and **vehicle recommendation**, developed as a Bachelor's thesis. The project combines a Flask backend with pre-trained ML models and a Flutter frontend.

---

## Overview

Users enter car specifications (brand, model, year, mileage, engine power, damage reports, etc.) and receive:
- An **AI-predicted sale price** (XGBoost model)
- **Similar car recommendations** (hybrid content-based + collaborative filtering)

---

## Project Structure

```
Bachelorarbeit_KI_preissystem/
├── 1-cleaning/               # Data cleaning pipeline
├── 2-EDA/                    # Exploratory data analysis
├── 3-preprocessing/          # Feature engineering & encoding
├── 4-spliting/               # Train/test split
├── 5-modelling/              # Model training (Linear, XGBoost)
│   ├── model_linear.joblib
│   └── model_xGboox.joblib   # Primary model (XGBoost)
├── Data/
│   ├── carData/              # Raw datasets
│   ├── usecar_image/         # Car images (organized by folder)
│   └── used_cars_dataset.xlsx
├── backend/
│   ├── app.py                # Flask entry point
│   ├── formular.py           # Price prediction endpoint
│   └── created_filter_car.py # Car browsing & recommendation routing
├── recommendsystem/
│   ├── hybrid_filter.py      # Recommendation engine core
│   ├── filter/
│   │   ├── model_filter.py   # Recommendations by car model
│   │   ├── price_filter.py   # Recommendations by budget
│   │   └── milleage_filter.py
│   ├── cosine_similarity.joblib                            # Content-based matrix
│   ├── cosine_similarity_collaborativ_filter_item.joblib   # Collaborative matrix
│   └── dataFrame.joblib      # Pre-loaded car dataset (~400 cars)
├── templates/usecar_ki_system/ # Flutter frontend
│   └── lib/
│       ├── features/         # UI screens & API clients
│       ├── models/           # Data models
│       └── routes/           # Navigation
├── app.py                    # Root Flask launcher
└── requirements.txt
```

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Python, Flask 3.0, Flask-CORS |
| ML | XGBoost, Scikit-learn, Pandas, NumPy, JobLib |
| Recommendation | Cosine similarity (content-based + collaborative) |
| Frontend | Flutter 3.9, Dart |
| Data | Jupyter Notebooks, OpenCV, Matplotlib |

---

## Machine Learning

### Price Prediction

- **Model:** XGBoost regressor (`5-modelling/model_xGboox.joblib`)
- **Input:** 24 features — brand, model, year, engine power (kW/hp), transmission, mileage, fuel type, TUV days, number of previous owners, body style, tire type, and 12 binary damage flags
- **Output:** Predicted sale price (float)

### Recommendation System

A hybrid filter that blends two similarity matrices:

```
Score = (1 - alpha) × content_score + alpha × collab_score
```

Default `alpha = 0.5` (equal weighting). Three recommendation modes:
- **By model name** — finds cars similar to a selected model
- **By budget** — filters cars within 80–220% of a given price
- **By mileage** — finds cars with similar usage

---

## API Endpoints

Base URL: `http://localhost:5000`

| Method | Route | Description |
|---|---|---|
| `POST` | `/submit_form` | Predict car price |
| `GET` | `/cars` | List all available cars |
| `GET` | `/recommend/<model_name>` | Recommend by car model |
| `GET` | `/recommend_price/<budget>` | Recommend by budget |
| `GET` | `/usecar_image/<folder>/<filename>` | Serve car image |

### Price Prediction Request

```json
{
  "technic": {
    "Brand": "VW",
    "Model": "Golf",
    "year_of_manufacture": 2018,
    "Engine_power(kilowatt)": 110,
    "Engine_power_(Horsepower)": 150,
    "Transmission_type": "Manual",
    "Mileage": 85000,
    "Fueltype": "Diesel",
    "nextTUV": 365,
    "Nber_previous_owners": 2,
    "Body_style": "Sedan",
    "Tire_type": "All-season",
    "Accident_history": "No"
  },
  "damaged": {
    "damaged_front": false,
    "damaged_rear": false,
    "damaged_left_side": false,
    "damaged_interior": false,
    "damaged_exterior": false,
    "damaged_tire": false,
    "damaged_rim": false,
    "damaged_roof_beam": false,
    "damaged_left_door": false,
    "damaged_right_door": false,
    "damaged_seats": false,
    "interior_dirty": false,
    "damaged_carosserie": false
  }
}
```

### Price Prediction Response

```json
{
  "status": "success",
  "message": "Form received!",
  "predicted_price": 12850.50
}
```

---

## Setup & Running

### 1. Python Backend

```bash
# Create and activate virtual environment
python -m venv venv
source venv/Scripts/activate   # Windows
# source venv/bin/activate     # macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Start the Flask server
python app.py
```

The backend starts at `http://localhost:5000`.

### 2. Flutter Frontend

```bash
cd templates/usecar_ki_system

flutter pub get

# Run in browser
flutter run -d chrome

# Run on device/emulator
flutter run
```

### 3. ML Pipeline (optional — models are pre-trained)

Run the notebooks in order:

1. `1-cleaning/cleaningProcess.ipynb`
2. `2-EDA/categoricalsl_features.ipynb` & `numericals_feature.ipynb`
3. `3-preprocessing/preprocessing.ipynb`
4. `4-spliting/data_spliting.ipynb`
5. `5-modelling/algorithmu.ipynb`
6. `recommendsystem/recommend_system.ipynb`

---

## Data

- **Dataset:** ~400 used car listings (`Data/used_cars_dataset.xlsx`)
- **Images:** Organized per car in `Data/usecar_image/` (served by the backend)
- **Pre-trained artifacts:** `.joblib` files in `5-modelling/` and `recommendsystem/`

---

## Notes

- Comments throughout the codebase are in German (TÜV = German vehicle inspection)
- XGBoost was selected over linear regression based on accuracy benchmarks in `5-modelling/algorithmu.ipynb`
- The Flutter app targets web, Android, and iOS from a single codebase
