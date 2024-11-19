import pandas as pd

food_df = pd.read_csv('food.csv')  #names and ids
nutrient_df = pd.read_csv('food_nutrient.csv')  #nutrient values
nutrient_def_df = pd.read_csv('nutrient.csv')  #nutrient info


relevant_nutrient_ids = [1003, 1004, 1005, 2000, 1235, 1093, 1051]  

relevant_nutrients = nutrient_def_df[nutrient_def_df['id'].isin(relevant_nutrient_ids)]

ingredient_nutrients = nutrient_df.merge(food_df, left_on='fdc_id', right_on='fdc_id', how='inner')

ingredient_nutrients = ingredient_nutrients[ingredient_nutrients['nutrient_id'].isin(relevant_nutrient_ids)]

pivoted_data = ingredient_nutrients.pivot_table(index=['description'], 
                                                columns=['nutrient_id'], 
                                                values='amount', 
                                                aggfunc='first')

pivoted_data.columns = ['Protein (g)', 'Total Fat (g)', 'Carbs (g)', 'Sugar (g)', 'Sugar Added (g)', 'Sodium (mg)', 'Water (g)']  #fix this

#reset index so that 'description' (ingredient name) is a column
pivoted_data.reset_index(inplace=True)

#export data to a CSV or Excel file
pivoted_data.to_csv('ingredients_macronutrients.csv', index=False)
pivoted_data.to_excel('ingredients_macronutrients.xlsx', index=False)

print("Data exported successfully!")
