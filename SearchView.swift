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
    func fetchIngredients() {
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(searchText)&pageSize=5&api_key=pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj
") else {
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
                            Ingredient(name: food.description, info: "Category: \(food.foodCategory ?? "N/A")")
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
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
