# setup_firestore.py
# A script to programmatically set up the initial Firestore data structure.
# This script is designed to be run from the Google Cloud Shell.

import firebase_admin
from firebase_admin import firestore

# --- 1. INITIALIZE FIREBASE ADMIN SDK ---
# When running in a Google Cloud environment like Cloud Shell, the SDK can
# automatically find the project's credentials and project ID.
# We do NOT need a service account key file.

print("--> Initializing Firebase Admin SDK using Application Default Credentials...")

try:
    # This simple initialization is a
    # ll that's needed in this environment.
    app = firebase_admin.initialize_app()
    db = firestore.client()
    project_id = app.project_id
    print(f"--> SDK Initialized successfully for project: {project_id}")
except Exception as e:
    print(f"CRITICAL ERROR: Could not initialize Firebase Admin SDK. {e}")
    print("Please ensure you are running this script from a Google Cloud Shell terminal inside your project.")
    exit()

# --- 2. DEFINE THE DATA AND PATHS ---
USER_ID = 'test-user-01'
USER_PATH = f"users/{USER_ID}"

# Data for the user profile document
user_data = {
    'email': 'test@example.com',
    'createdAt': firestore.SERVER_TIMESTAMP  # Good practice to add a timestamp
}

# Data for the sample receipt document (using your OCR schema)
receipt_data = {
    'category': 'Food',
    'currency': 'USD',
    'ingested_at': '2025-07-24T19:50:00.848PM UTC+5:30',
    'merchant_name': 'IKEA Food Place',
    'total_amount': 32.1,
    'transaction_date': '2019-01-11',
    'items': [
        {'name': 'Cheese Burger', 'price': 5.99, 'qty': 1},
        {'name': 'Soda', 'price': 0.49, 'qty': 4},
        {'name': 'Cinnamon Bun', 'price': 1.00, 'qty': 2}
    ]
}

# --- 3. WRITE DATA TO FIRESTORE ---
# This section performs the database operations.

try:
    print(f"\n--> Setting up user document at: /{USER_PATH}")
    # Get a reference to the user document and set its data.
    # .set() will create or overwrite the document.
    user_ref = db.document(USER_PATH)
    user_ref.set(user_data)
    print(f"--> User document for '{user_data['email']}' created/updated.")

    print(f"--> Adding a new receipt to subcollection: /{USER_PATH}/receipts")
    # Get a reference to the receipts subcollection and add a new document.
    # .add() creates a document with a new, automatically generated ID.
    update_time, receipt_ref = user_ref.collection('receipts').add(receipt_data)
    print(f"--> Successfully created receipt with Auto-ID: {receipt_ref.id}")

    print("\n✅ Firestore setup complete!")
    print(f"You can now find the data at the path: /{USER_PATH}/receipts/{receipt_ref.id}")

except Exception as e:
    print(f"AN ERROR OCCURRED: {e}")