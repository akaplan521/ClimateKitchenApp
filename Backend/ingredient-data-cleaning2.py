import pandas as pd
import re

food_df = pd.read_csv('food.csv')  #names and ids
nutrient_df = pd.read_csv('food_nutrient.csv', low_memory=False)  #nutrient values
nutrient_def_df = pd.read_csv('nutrient.csv')  #nutrient info


relevant_nutrient_ids = [1003, 1004, 1005, 2000, 1235, 1093, 1051]  

#filtering the nutrient definitions to have only the specified nutrients and only the specified info 
relevant_nutrients = nutrient_def_df[nutrient_def_df['id'].isin(relevant_nutrient_ids)]
relevant_nutrients = relevant_nutrients.loc[:,["id", "name", "unit_name"]]

#filtering the ingredient nutrients to include only the specified nutrients and only the specified info 
filtered_nutrient_df = nutrient_df[nutrient_df['nutrient_id'].isin(relevant_nutrient_ids)]
filtered_nutrient_df = filtered_nutrient_df.loc[:,["id", "fdc_id", "nutrient_id", "amount"]]

#including only food name and id for the foods
filtered_foods = food_df.loc[:,["fdc_id", "description"]]

#put everything to upercase and remove duplicates

#remove certain keywords
def clean_description(desc):
    if isinstance(desc, str):
        desc = re.sub(r', Pass \d+|, Region \d+|, [nN]/[aA]|, [A-Z]+\d+', '', desc)
    return desc.strip() if isinstance(desc, str) else desc 

#take only first three csv of the description
def simplify_description(desc):
    if isinstance(desc, str):
        simplified = ', '.join(desc.split(', ')[:3])
        return simplified
    return desc



#calling written methods
filtered_foods['description'] = filtered_foods['description'].apply(clean_description)
filtered_foods['description'] = filtered_foods['description'].apply(simplify_description)

#make everything lowercase
filtered_foods['description'] = filtered_foods['description'].str.lower()

#remove duplicates
filtered_foods.drop_duplicates(subset='description', inplace=True)

#export to csv
filtered_foods.to_csv('filtered_foods.csv', index=False)


#####MERGING FOR VIEWING PURPOSE ONLY NOT SETUP THE DB LIKE THIS

# ingredient_nutrients = filtered_nutrient_df.merge(food_df, left_on='fdc_id', right_on='fdc_id', how='inner')

# def simplify_description(desc):
#     if isinstance(desc, str):
#         simplified = ', '.join(desc.split(', ')[:3])
#         return simplified
#     return desc

# ingredient_nutrients['simplified_description'] = ingredient_nutrients['description'].apply(simplify_description)

# pivoted_data = ingredient_nutrients.pivot_table(
#     index=['simplified_description'],
#     columns=['nutrient_id'],
#     values='amount',
#     aggfunc='mean'  
# )

# nutrient_mapping = {
#     1003: 'Protein (g)',
#     1004: 'Total Fat (g)',
#     1005: 'Carbs (g)',
#     2000: 'Sugar (g)',
#     1235: 'Sugar Added (g)',
#     1093: 'Sodium (mg)',
#     1051: 'Water (g)'
# }
# pivoted_data.columns = [nutrient_mapping.get(col, col) for col in pivoted_data.columns]

# pivoted_data.reset_index(inplace=True)

# pivoted_data.to_csv('ingredients_macronutrients2.csv', index=False)
# pivoted_data.to_excel('ingredients_macronutrients2.xlsx', index=False)

# print("Data exported successfully!")