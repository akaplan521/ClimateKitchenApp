//
//  RecipeView.swift
//  ClimateKitchen
//


import SwiftUI
import SQLite3

struct RecipeView: View {
    let recipeId: Int
    @EnvironmentObject var settings: Settings
    @State private var showReviewView = false
    @State private var instructions: String = ""
    @State private var ingredients: [(id: Int, name: String, quantity: String, prep: String)] = []
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var spice: Int = 0
    @State private var temp: Int = 0
    @State private var likes: Int = 0
    @State private var dislikes: Int = 0
    @State private var made: Int = 0
    @State private var difficulty: Int = 0
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text(name)
                    .font(.largeTitle).bold()
                    .padding()
                
                // Spice and temp ratings
                HStack(spacing: 20) { // Space between spice and temp symbols
                    // spice
                    HStack(spacing: 5) {
                        ForEach(0..<5) { index in
                            Text(index < spice ? "🌶️" : "⚪️")
                            .font(.title)
                        }
                    }
                    
                    // temp
                    HStack(spacing: 5) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < temp ? "flame.fill" : "flame")
                                .foregroundColor(index < temp ? .orange : .gray)
                                .font(.title)
                        }
                    }
                }
                .padding()
                
                // likes and dislikes
                HStack(spacing: 20) { // Space between likes and dislikes symbols
                    // difficulty
                    Text("Difficulty: \(difficulty)/5")
                    // likes
                    HStack(spacing: 5) {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("\(likes)")
                    }
                    
                    // dislikes
                    HStack(spacing: 5) {
                        Image(systemName: "hand.thumbsdown.fill")
                        Text("\(dislikes)")
                    }
                    // madecount
                    Text("(\(made))")
                }
                
                
                
                // ingredients
                Text("Ingredients")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(ingredients, id: \.id) { ingredient in
                    VStack(alignment: .leading) {
                        Text("\(ingredient.quantity), \(ingredient.name), \(ingredient.prep)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing, .bottom], 20)
                    }
                }
                
                // instructions
                let instructionSplit = instructions.split(separator: "+").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                Text("Instructions")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(Array(instructionSplit.enumerated()), id: \.offset) { index, instruction in
                    VStack(alignment: .leading) {
                        Text("\(index + 1). \(instruction)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing, .bottom], 20)
                    }
                }
                
                // notes
                let noteSplit = notes.split(separator: "+").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                Text("Notes")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(noteSplit, id: \.self) { note in
                    VStack(alignment: .leading) {
                        Text(note)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing, .bottom], 20)
                            .background(Color(.systemGray6)) // fix formatting if time
                    }
                }

                // 'i made this' button
                Button(action: {
                    showReviewView = true}) {
                        Text("I Made This!")
                    }.navigationDestination(isPresented: $showReviewView) {
                        ReviewView().environmentObject(Settings()).navigationBarBackButtonHidden(true)
                    }
            }
        }
        .onAppear(perform: fetchRecipeDetails)
        //.navigationTitle("Recipe Details")        dont want this to show up at the top
    }
    
    // fetch recipe details
    func fetchRecipeDetails() {
        let details = fetchRecipeDetailsFromDB(recipeId: recipeId)
        name = details.name
        instructions = details.instructions
        notes = details.notes
        ingredients = details.ingredients
        spice = details.spice
        temp = details.temp
        likes = details.likes
        dislikes = details.dislikes
        difficulty = details.difficulty
    }
}
func fetchRecipeDetailsFromDB(recipeId: Int) -> (name: String, instructions: String, notes: String, ingredients: [(id: Int, name: String, quantity: String, prep: String)], spice: Int, temp: Int, likes: Int, dislikes: Int, made: Int, difficulty: Int) {
    var db: OpaquePointer?
    let dbPath = Bundle.main.path(forResource: "ClimateKitchen", ofType: "db") ?? ""
    
    if sqlite3_open(dbPath, &db) != SQLITE_OK {
        print("Failed to open database.")
        return ("", "", "", [], 0, 0, 0, 0, 0, 0)
    }
    
    // query for recipe details
    let recipeQuery = "SELECT recipeName, instructions, notes, spice, temp, likes, dislikes, made, difficulty FROM Recipes WHERE recipe_id = \(recipeId)"
    var recipeStatement: OpaquePointer?
    var name = ""
    var instructions = ""
    var notes = ""
    var spice = 0
    var temp = 0
    var likes = 0
    var dislikes = 0
    var made = 0
    var difficulty = 0
    
    if sqlite3_prepare_v2(db, recipeQuery, -1, &recipeStatement, nil) == SQLITE_OK {
        if sqlite3_step(recipeStatement) == SQLITE_ROW {
            name = String(cString: sqlite3_column_text(recipeStatement, 0))
            instructions = String(cString: sqlite3_column_text(recipeStatement, 1))
            notes = String(cString: sqlite3_column_text(recipeStatement, 2))
            spice = Int(sqlite3_column_int(recipeStatement, 3))
            temp = Int(sqlite3_column_int(recipeStatement, 4))
            likes = Int(sqlite3_column_int(recipeStatement, 5))
            dislikes = Int(sqlite3_column_int(recipeStatement, 6))
            made =  Int(sqlite3_column_int(recipeStatement, 6)) // check if this second argument is correct because ordering is dif but db not up to date
            difficulty = Int(sqlite3_column_int(recipeStatement, 7)) //f or this too
        }
    }
    sqlite3_finalize(recipeStatement)
    
    // Query for recipe ingredients with quantity and prep
    var ingredientQuery = """
        SELECT RecipeIngredients.recipe_ingredient_id, RecipeIngredients.ingredient_name, RecipeIngredients.quantity, RecipeIngredients.prep
        FROM RecipeIngredients
        WHERE RecipeIngredients.recipe_id = \(recipeId)
        """
    var ingredientStatement: OpaquePointer?
    var ingredients: [(id: Int, name: String, quantity: String, prep: String)] = []
    
    if sqlite3_prepare_v2(db, ingredientQuery, -1, &ingredientStatement, nil) == SQLITE_OK {
        while sqlite3_step(ingredientStatement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(ingredientStatement, 0))
            let name = String(cString: sqlite3_column_text(ingredientStatement, 1))
            let quantity = String(cString: sqlite3_column_text(ingredientStatement, 2))
            let prep = String(cString: sqlite3_column_text(ingredientStatement, 3))
            ingredients.append((id: id, name: name, quantity: quantity, prep: prep))
        }
    }
    sqlite3_finalize(ingredientStatement)
    
    sqlite3_close(db)
    return (name, instructions, notes, ingredients, spice, temp, likes, dislikes, made, difficulty)
}
