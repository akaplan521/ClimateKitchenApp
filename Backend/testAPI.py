import requests

# Replace 'YOUR_API_KEY' with your actual FoodData Central API key
api_key = 'pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj'
base_url = 'https://api.nal.usda.gov/fdc/v1/foods/search'


# Function to make a search request
def search_food(query):
    params = {
        'api_key': api_key,
        'query': query,
        'dataType': 'Foundation',  # Specifies Foundation Foods
        'pageSize': 5  # Limit the number of results for easier testing
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        return response.json()  # Returns the JSON response
    else:
        print(f"Error {response.status_code}: {response.text}")
        return None

# Test with a sample query, such as "carrot"
query = input("Search Query:")
result = search_food("query")



# Sample API response structure

# Function to parse and display simplified data
def parse_food_data(result):
    foods = result.get('foods', [])
    for food in foods:
        print(f"Food ID: {food.get('fdcId')}")
        print(f"Description: {food.get('description')}")
        
        # Extract key nutrients (e.g., protein, fat, carbohydrates, and energy)
        nutrients = food.get('foodNutrients', [])
        for nutrient in nutrients:
            nutrient_name = nutrient.get('nutrientName')
            if nutrient_name in ['Protein', 'Total lipid (fat)', 'Carbohydrate, by difference', 'Energy (Atwater General Factors)']:
                print(f"  {nutrient_name}: {nutrient.get('value')} {nutrient.get('unitName')}")
        print("-" * 40)

# Call the function to display the data
parse_food_data(result)