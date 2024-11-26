import sqlite3
import csv
import chardet


#connect to db
conn = sqlite3.connect('ClimateKitchen.db')
cursor = conn.cursor()

#--------------UNCOMMENT IF NEED TO CHANGE THE TABLE SETUP----------------
cursor.execute('DROP TABLE IF EXISTS UserInfo')
cursor.execute('DROP TABLE IF EXISTS UserRecipes')

#user info table with allergies
cursor.execute('''
CREATE TABLE IF NOT EXISTS UserInfo (
    fb_id INTEGER PRIMARY KEY,
    name TEXT,
    location TEXT,         
    none BOOLEAN,   
    peanuts BOOLEAN,        
    tree_nuts BOOLEAN,   
    gluten BOOLEAN,   
    dairy BOOLEAN,        
    eggs BOOLEAN,
    shellfish BOOLEAN,   
    fish BOOLEAN,        
    soy BOOLEAN,  
    og BOOLEAN      
)
''')

#user recipe table
cursor.execute('''
CREATE TABLE IF NOT EXISTS UserRecipes (
    user_recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fb_id INTEGER,
    recipeName TEXT NOT NULL,
    instructions TEXT,
    notes TEXT,
    FOREIGN KEY (fb_id) REFERENCES UserInfo(fb_id)
)
''')

#favorite recipes table
cursor.execute('''
CREATE TABLE IF NOT EXISTS FavRecipes (
    fav_recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fb_id INTEGER,
    user_recipe_id INT,
    FOREIGN KEY (fb_id) REFERENCES UserInfo(fb_id),
    FOREIGN KEY (user_recipe_id) REFERENCES UserRecipes(user_recipe_id)
)
''')

conn.commit()
print("Recipe tables created successfully.")
conn.close()
