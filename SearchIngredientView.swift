//modular component for RecipeCreateView

import SwiftUI

struct SearchIngredientView: View {
    @Binding var selectedIngredient: String //to return the selected ingredient name
    @Binding var selectedFdcId: String //to return the selected FDC ID
    @Binding var searchText: String
    @State private var searchResults = [IngredientResult]()
    
    struct IngredientResult: Identifiable {
        let id: String //FDC_ID
        let name: String //ingredient Name
    }
    
    var body: some View {
        VStack {
            //search Bar
            TextField("Ingredient search...", text: $searchText, onCommit: fetchIngredients)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            //search Results
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(searchResults) { result in
                        ForEach(searchResults) { result in
                            Button(action: {
                                handleResultSelection(result)
                            }) {
                                Text(result.name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(10)
                            }
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func fetchIngredients() {
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(searchText)&pageSize=5&api_key=pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(FoodDataResponse.self, from: data)
                    DispatchQueue.main.async {
                        searchResults = response.foods.map {
                            IngredientResult(id: "\($0.fdcId)", name: $0.description)
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func handleResultSelection(_ result: IngredientResult) {
        selectedIngredient = result.name
        selectedFdcId = result.id
        searchText = result.name
        searchResults = [] //clear results after selection
    }

}
