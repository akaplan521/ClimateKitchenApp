
import SwiftUI
import SQLite3
import UIKit


struct Recipe: Identifiable {
    let id: Int
    let name: String
    let info: String
}

struct RecipeHomeView: View {
    @State private var searchText = ""
    @State private var selectedFilters: Set<String> = []
    @State private var recipes: [Recipe] = []

    let filterOptions = ["Plant Based", "Gluten Free", "Vegan", "Easy", "Quick"]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    //search Bar
                    TextField("...search", text: $searchText, onCommit: fetchRecipes)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    //navigation to RecipeCreateView
                    NavigationLink(destination: RecipeCreateView().navigationBarBackButtonHidden(true)) {
                        Text("+")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 100)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }.padding(.trailing, 15)
                }

                //filter options displayed as bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filterOptions, id: \.self) { option in
                            Button(action: {
                                if selectedFilters.contains(option) {
                                    selectedFilters.remove(option)
                                } else {
                                    selectedFilters.insert(option)
                                }
                                fetchRecipes() //call fetchRecipes on any filter button pressed
                            }) {
                                Text(option)
                                    .padding()
                                    .background(selectedFilters.contains(option) ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                    .foregroundColor(selectedFilters.contains(option) ? Color.blue : Color.primary)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedFilters.contains(option) ? Color.blue : Color.gray, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                //display results as clickable buttons
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(recipes) { recipe in
                            Button(action: {
                                //TODO: nav to recipe "page"
                            }) {
                                Text(recipe.name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(index == 0 ? Color(.systemBlue).opacity(0.3) : Color(.systemGray5))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                BottomNavigationBar()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Search Recipes")
            .onAppear(perform: fetchRecipes) //call fetch on view load
        }
    }

    //fetch recipes dynamically from the db
    func fetchRecipes() {
        recipes = fetchRecipesFromDB(searchText: searchText, selectedFilters: selectedFilters)
    }
}

//function to fetch recipes from SQLite
func fetchRecipesFromDB(searchText: String, selectedFilters: Set<String>) -> [Recipe] {
    var db: OpaquePointer?
    let dbPath = Bundle.main.path(forResource: "ClimateKitchen", ofType: "db") ?? ""
    
    if sqlite3_open(dbPath, &db) != SQLITE_OK {
        print("Failed to open database.")
        return []
    }
    
    //base  query
    var query = "SELECT recipe_id, recipeName, instructions FROM Recipes WHERE 1=1"
    
    //add search text
    if !searchText.isEmpty {
        query += " AND recipeName LIKE '%\(searchText)%'"
    }
    
    //add filter conditions
    if selectedFilters.contains("Plant Based") {
        query += " AND plantBased = 1"
    }
    if selectedFilters.contains("Gluten Free") {
        query += " AND gf = 1"
    }
    if selectedFilters.contains("Vegan") {
        query += " AND vegan = 1"
    }
    if selectedFilters.contains("Easy") {
        query += " AND difficulty <= 0.5"
    }
    if selectedFilters.contains("Quick") {
        query += " AND (prepTime + cookTime) <= 60"
    }
    
    var statement: OpaquePointer?
    if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
        print("Failed to prepare statement.")
        sqlite3_close(db)
        return []
    }
    
    var recipes: [Recipe] = []
    while sqlite3_step(statement) == SQLITE_ROW {
        let id = Int(sqlite3_column_int(statement, 0))
        let name = String(cString: sqlite3_column_text(statement, 1))
        let info = String(cString: sqlite3_column_text(statement, 2))
        recipes.append(Recipe(id: id, name: name, info: info))
    }
    
    sqlite3_finalize(statement)
    sqlite3_close(db)
    return recipes
}
