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
}
