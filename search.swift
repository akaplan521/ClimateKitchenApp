//
//  ContentView.swift
//  climatekitchen
//
//  Created by user266919 on 10/13/24.
//

import SwiftUI

//temp cause might have dif vars
struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let info: String
}

struct SearchView: View {
    var searchText = ""
    var ingredients: [Ingredient] = [
        Ingredient(name: "Carrot", info: "blah carrot"),
        Ingredient(name: "Tomato", info: "blah tomato"),
        Ingredient(name: "Lettuce", info: "blah lettuce"),
        //fake data will be from db once setup
    ]
    //show only ingredients with substring that was searched. not the functionality we want but is fine for now.
    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        } 
        else {
            return ingredients.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                //search Bar
                TextField("Search for ingredients...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                //display results as clickable buttons
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredIngredients.indices, id: \.self) { index in
                            Button(action: {
                                //TODO: nav to ingredient "page"
                            }) {
                                Text(filteredIngredients[index].name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(index == 0 ? Color(.systemBlue).opacity(0.3) : Color(.systemGray5))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Search Ingredients")
        }
    }
}

struct ContentView: View {
    var body: some View {
        //for testing
        SearchView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
