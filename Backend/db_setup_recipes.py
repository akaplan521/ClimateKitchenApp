import sqlite3

#connect to db
conn = sqlite3.connect('ClimateKitchen.db')
cursor = conn.cursor()

cursor.execute('DROP TABLE IF EXISTS Recipes')
cursor.execute('DROP TABLE IF EXISTS RecipeIngredients')

#recipe table
cursor.execute('''
CREATE TABLE IF NOT EXISTS Recipes (
    recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipeName TEXT NOT NULL,
    instructions TEXT,
    notes TEXT,           
    spice FLOAT DEFAULT 0,  
    temp FLOAT DEFAULT 0,   
    likes INTEGER DEFAULT 0,  
    dislikes INTEGER DEFAULT 0, 
    taste TEXT,           
    plantBased BOOLEAN,   
    vegan BOOLEAN,        
    gf BOOLEAN,           
    made INTEGER DEFAULT 0,
    difficulty FLOAT DEFAULT 0,
    energy FLOAT,
    cookTime INTEGER,
    prepTime INTEGER
)
''')

#recipe ingredients table
cursor.execute('''
CREATE TABLE IF NOT EXISTS RecipeIngredients (
    recipe_ingredient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    ingredient_id INTEGER,
    quantity FLOAT,
    prep TEXT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
)
''')

conn.commit()
print("Recipe tables created successfully.")

#have to insert data in here either dynamically from app or with csv

#inserting data into just recipe table
file_path = 'Recipe_DB_final_CSV.csv'  

with open(file_path, newline='', encoding='utf-8') as recipes:
    reader = csv.DictReader(recipes)  #read as a dictionary 

    for row in reader:
        #prepare data for insertion
        recipe_id = row['id']
        recipe_name = row['recipeName']
        instructions = row['instructions']
        notes = row['notes']
        spice = float(row['spice']) if row['spice'] else None
        temp = float(row['temp']) if row['temp'] else None
        likes = int(row['likes']) if row['likes'] else 0
        dislikes = int(row['dislikes']) if row['dislikes'] else 0
        taste = row['taste'] if row['taste'] else None
        plant_based = int(row['plantBased'])
        gf = int(row['gf'])
        vegan = int(row['vegan'])
        made = int(row['made']) if row['made'] else 0
        energy = float(row['energy']) if row['energy'] else None
        cook_time = int(row['cook_time']) if row['cook_time'] else None
        prep_time = int(row['prep_time']) if row['prep_time'] else None

        # Insert data into the Recipes table
        cursor.execute('''
            INSERT INTO Recipes (
                recipe_id, recipeName, instructions, notes, spice, temp, likes, dislikes,
                taste, plantBased, gf, vegan, made, energy, cookTime, prepTime
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            recipe_id, recipe_name, instructions, notes, spice, temp, likes, dislikes,
            taste, plant_based, gf, vegan, made, energy, cook_time, prep_time
        ))
conn.commit()
conn.close()

print("Recipes and their ingredients inserted successfully!")
