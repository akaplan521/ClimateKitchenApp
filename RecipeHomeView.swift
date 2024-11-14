import SwiftUI
import UIKit

// Cierra: Recipe Home page
//temp cause might have dif vars
struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let info: String
}
struct RecipeHomeView: View {
    @State var searchText = ""
    var recipes: [Recipe] = [
        Recipe(name: "Winter Squash Risotto", info: "blah risotto"),
        Recipe(name: "Viniagrette", info: "blah viniagrette"),
        Recipe(name: "Garden Salad", info: "blah salad"),
        //fake data will be from db once setup
    ]
    //show only ingredients with substring that was searched. not the functionality we want but is fine for now.
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        }
        else {
            return recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    //search Bar
                    TextField("...search", text: $searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    NavigationLink(destination: RecipeCreateView().navigationBarBackButtonHidden(true)) {
                        Text("+")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 100)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                //display results as clickable buttons
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredRecipes.indices, id: \.self) { index in
                            Button(action: {
                                //TODO: nav to recipe "page"
                            }) {
                                Text(filteredRecipes[index].name)
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
            .navigationTitle("Search Recipes")
        }
        BottomNavigationBar()
    }
}


// TODO: this is a backup, remove when above is finalized and stable
struct RecipeHomeView2: View {
    @State private var showRecipeCreateView = false
    @State private var showRecipeView = false
    
    var body: some View {
        NavigationStack() {
            VStack() {
                
                // Button to Create Recipe page
                NavigationLink(destination: RecipeCreateView().navigationBarBackButtonHidden(true)) {
                    Text("Create a Recipe")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                // Button to View a Recipe
                NavigationLink(destination: RecipeView().environmentObject(Settings()).navigationBarBackButtonHidden(true)) {
                    Text("View Recipes")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
        BottomNavigationBar()
    }
}

