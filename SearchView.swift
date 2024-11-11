import SwiftUI
import UIKit

// Alexa
struct FoodDataResponse: Codable {
    let foods: [Food]
}

struct Food: Codable {
    let description: String
    let foodCategory: String?
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let info: String
    var nutrients: [Nutrient]
}

struct Nutrient: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let unit: String
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
                            Ingredient(name: food.description, info: "Category: \(food.foodCategory ?? "N/A")", nutrients: [])
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
