import sqlite3
import csv
import chardet


#connect to db
conn = sqlite3.connect('ClimateKitchen.db')
cursor = conn.cursor()

#--------------UNCOMMENT IF NEED TO CHANGE THE TABLE SETUP----------------

cursor.execute('DROP TABLE IF EXISTS Recipes')
#cursor.execute('DROP TABLE IF EXISTS RecipeIngredients')

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
    aroma TEXT,
    taste TEXT,  
    texture TEXT,         
    plantBased BOOLEAN,   
    vegan BOOLEAN,        
    gf BOOLEAN,           
    made INTEGER DEFAULT 0,
    difficulty FLOAT DEFAULT 0,
    energy FLOAT,
    cookTime INTEGER,
    prepTime INTEGER,
    servings INTEGER
)
''')

#recipe ingredients table
cursor.execute('''
CREATE TABLE IF NOT EXISTS RecipeIngredients (
    recipe_ingredient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    ingredient_id INTEGER,
    ingredient_name TEXT,
    quantity TEXT,
    prep TEXT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
)
''')



conn.commit()
print("Recipe tables created successfully.")

#have to insert data in here either dynamically from app or with csv

#test encoding of the csv file
#with open('Recipe_DB_final_copy.csv', 'rb') as f:
#    result = chardet.detect(f.read())
#    print(result)
#inserting data into just recipe table

file_path = 'EMILY_DB_FINAL_CSV.csv'  

with open(file_path, newline='', encoding='utf-8-sig') as recipes:
    reader = csv.DictReader(recipes)  #read as a dictionary 

    for row in reader:
        #prepare data for insertion
        recipe_id = row['id']
        recipe_name = row['recipe_name']
        instructions = row['instructions']
        notes = row['notes']
        spice = float(row['spice']) if row['spice'] else None
        temp = float(row['temp']) if row['temp'] else None
        likes = int(row['likes']) if row['likes'] else 0
        dislikes = int(row['dislikes']) if row['dislikes'] else 0
        aroma = row['aroma'] if row['aroma'] else None
        taste = row['taste'] if row['taste'] else None
        texture = row['texture'] if row['texture'] else None
        plant_based = int(row['plantBased'])
        gf = int(row['gf'])
        vegan = int(row['vegan'])
        made = int(row['made']) if row['made'] else 0
        energy = float(row['energy']) if row['energy'] else None
        cook_time = int(row['cook_time']) if row['cook_time'] else None
        prep_time = int(row['prep_time']) if row['prep_time'] else None
        servings = int(row['Servings']) if row['Servings'] else None


        # Insert data into the Recipes table
        cursor.execute('''
            INSERT INTO Recipes (
                recipe_id, recipeName, instructions, notes, spice, temp, likes, dislikes, aroma,
                taste, texture, plantBased, gf, vegan, made, energy, cookTime, prepTime, servings
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            recipe_id, recipe_name, instructions, notes, spice, temp, likes, dislikes, aroma,
            taste, texture, plant_based, gf, vegan, made, energy, cook_time, prep_time, servings
        ))
conn.commit()
conn.close()

print("Recipes inserted successfully!")
