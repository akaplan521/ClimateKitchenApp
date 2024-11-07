import SwiftUI
import UIKit

// Alexa: temp cause might have dif vars
struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let info: String
}

// Alexa: Search page
struct SearchView: View {
    @State private var searchText = ""
    @State private var ingredients = [Ingredient]()
    

    var body: some View {
        NavigationView {
            VStack {
                //search Bar
                TextField("Search for ingredients...", text: $searchText, onCommit: fetchIngredients)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                //display results as clickable buttons
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredIngredients.indices, id: \.self) { index in
                            NavigationLink(destination: IngredientDetailView(ingredient: filteredIngredients[index])) {
                                Text(filteredIngredients[index].name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(index == 0 ? Color(.systemBlue).opacity(0.3) : Color(.systemGray5))
                                    .cornerRadius(10)
                                    .foregroundColor(.black) // Ensures text is visible
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                BottomNavigationBar()
            }
            .navigationTitle("Search Ingredients")
        }
    }
//api key = pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj
    func fetchIngredientData(for ingredientName: String, completion: @escaping (Ingredient) -> Void) {
    let urlString = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(ingredientName)&pageSize=1&api_key=pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(FoodSearchResult.self, from: data)
                if let foodItem = result.foods.first {
                    let nutrients = foodItem.foodNutrients.map { nutrient in
                        Nutrient(name: nutrient.nutrientName, amount: nutrient.value, unit: nutrient.unitName)
                    }
                    let ingredient = Ingredient(name: foodItem.description, info: "Info about \(foodItem.description)", nutrients: nutrients)
                    DispatchQueue.main.async {
                        completion(ingredient)
                    }
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
    }.resume()
}

}

        struct IngredientDetailView: View {
            var ingredient: Ingredient
        
            var body: some View {
                Text(ingredient.info)
                    .navigationTitle(ingredient.name)
                    .padding()
            }
        }
        
        struct FoodDataResponse: Codable {
            let foods: [Food]
        }
        
        struct Food: Codable {
            let fdcId: Int
            let description: String
            let foodCategory: String?
        }
}
