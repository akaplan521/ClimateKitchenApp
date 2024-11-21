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
                                    .lineLimit(1) //limits text to fit on one line and ends with ...
                            }
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func fetchIngredients() {
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search") else {
                print("Invalid URL")
                return
            }

            //query parameters
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = [
                URLQueryItem(name: "query", value: searchText),
                URLQueryItem(name: "pageSize", value: "8"),  // Adjust number of results
                URLQueryItem(name: "dataType", value: "Foundation,SR Legacy"),  // Restrict to Foundation data type
                URLQueryItem(name: "api_key", value: "pjhbzbCk8DPYCJ6eFzt60gC2wUXQ1fui6EhsQhIj")
            ]

            //final URL with parameters
            guard let finalURL = urlComponents?.url else {
                print("Error constructing URL")
                return
            }

            //API request
            var request = URLRequest(url: finalURL)
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
