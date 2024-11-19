import sqlite3
import pandas as pd

# Set up db
db_path = 'ClimateKitchen.db'
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Drop existing tables if they exist
cursor.execute('DROP TABLE IF EXISTS Ingredients')
cursor.execute('DROP TABLE IF EXISTS Nutrients')
cursor.execute('DROP TABLE IF EXISTS IngredientNutrientValues')

# Ingredients table with fdc_id
cursor.execute('''
CREATE TABLE IF NOT EXISTS Ingredients (
    fdc_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
)
''')

# Nutrients table
cursor.execute('''
CREATE TABLE IF NOT EXISTS Nutrients (
    nutrient_id INTEGER PRIMARY KEY,
    nutrient_name TEXT NOT NULL,
    unit_name TEXT NOT NULL
)
''')

# Ingredient and nutrient values join table
cursor.execute('''
CREATE TABLE IF NOT EXISTS IngredientNutrientValues (
    fdc_id INTEGER,
    nutrient_id INTEGER,
    amount FLOAT,
    PRIMARY KEY (fdc_id, nutrient_id),
    FOREIGN KEY (fdc_id) REFERENCES Ingredients(fdc_id),
    FOREIGN KEY (nutrient_id) REFERENCES Nutrients(nutrient_id)
)
''')

conn.commit()
print("Tables created successfully.")

#load data from CSV files
filtered_foods = pd.read_csv('filtered_foods.csv')  #create dataframes from csv files
relevant_nutrients = pd.read_csv('nutrient.csv')
filtered_nutrient_df = pd.read_csv('nutrients_filtered.csv')

#populate Ingredients table using fdc_id and name
for _, row in filtered_foods.iterrows():
    cursor.execute("INSERT OR IGNORE INTO Ingredients (fdc_id, name) VALUES (?, ?)", (row['fdc_id'], row['description']))


#populate Nutrients table
for _, row in relevant_nutrients.iterrows():
    cursor.execute(
        "INSERT OR IGNORE INTO Nutrients (nutrient_id, nutrient_name, unit_name) VALUES (?, ?, ?)",
        (row['id'], row['name'], row['unit_name'])
    )
print("first two tables populated")
conn.commit()
# Create an ingredient map based on fdc_id for easy lookup
ingredient_map = {row[0]: row[1] for row in cursor.execute("SELECT fdc_id, ingredient_id FROM Ingredients").fetchall()}

# Insert data into IngredientNutrientValues table
for _, row in filtered_nutrient_df.iterrows():
    ingredient_id = ingredient_map.get(row['fdc_id'])
    if ingredient_id:
        cursor.execute(
            "INSERT OR REPLACE INTO IngredientNutrientValues (ingredient_id, nutrient_id, amount) VALUES (?, ?, ?)",
            (ingredient_id, row['nutrient_id'], row['amount'])
        )
    else:
        x =10#print(f"Ingredient with fdc_id {row['fdc_id']} not found in ingredient_map")

# Commit changes and close connection
conn.commit()
conn.close()

print("Data loaded into SQLite database successfully!")
