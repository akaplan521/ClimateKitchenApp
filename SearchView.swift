import SwiftUI
import UIKit

// Alexa: temp cause might have dif vars
struct FoodDataResponse: Codable {
    let foods: [Food]
}

struct Food: Codable {
    let description: String
    let foodCategory: String?
    let foodNutrients: [Nutrient]  // Use the modified Nutrient struct
    let fdcId: Int  
    
    enum CodingKeys: String, CodingKey {
        case description
        case foodCategory
        case foodNutrients
        case fdcId  //map the JSON key directly
    }
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let info: String
    var nutrients: [Nutrient]  // This will map directly from "foodNutrients"
}


struct Nutrient: Identifiable, Codable {
    let id = UUID()
    let nutrientId: Int
    let nutrientName: String
    let value: Double
    let unitName: String

    enum CodingKeys: String, CodingKey {
        case nutrientId
        case nutrientName
        case value
        case unitName
    }
}


// Alexa: Search page
struct SearchView: View {
    @State private var searchText = ""
    @State private var ingredients = [Ingredient]()
    
    var filteredIngredients: [Ingredient] {
            if searchText.isEmpty {
                return ingredients
            } else {
                return ingredients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
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
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Search Ingredients")
        }
    }
//api key = pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj
    func fetchIngredients() {
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(searchText)&pageSize=5&api_key=pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj")
        else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let foodData = try decoder.decode(FoodDataResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.ingredients = foodData.foods.map { food in
                            Ingredient(
                                name: food.description,
                                info: "Category: \(food.foodCategory ?? "N/A")",
                                nutrients: food.foodNutrients
                                    .filter { [1003, 1004, 1005, 2000, 1235, 1093, 1051].contains($0.nutrientId) } // Filter for specific nutrients
                                                        )
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }

}

