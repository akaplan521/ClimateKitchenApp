import sqlite3
import csv
import chardet


#connect to db
conn = sqlite3.connect('ClimateKitchen.db')
cursor = conn.cursor()

#--------------UNCOMMENT IF NEED TO CHANGE THE TABLE SETUP----------------

cursor.execute('DROP TABLE IF EXISTS Users')
#cursor.execute('DROP TABLE IF EXISTS RecipeIngredients')


#recipe ingredients table
cursor.execute('''
CREATE TABLE IF NOT EXISTS Users (
    
)
''')



conn.commit()
print("user table created.")


