//
//  RecipeInView.swift
//  SearchTestingApp
//
//
//  RecipeView2.swift
//  ClimateKitch
//
//  Created by Cierra Church on 11/20/24.
//

import SwiftUI
import SQLite3

// how to make a check box https://www.appcoda.com/swiftui-checkbox/
// TODO: will change this to style we want
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}


struct RecipeInView: View {
    @EnvironmentObject var settings: Settings
    let recipeId: Int
    @State private var instructions: String = ""
    @State private var ingredients: [(id: Int, name: String, quantity: String, prep: String)] = []
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var isChecked: [Bool] = []
    @State var prepTime = 0
    @State var cookTime = 0
    @State private var showReviewView = false
    @State private var preheatTime: Int?
    // This calculates the BTU used from appliance type, preheat time, and cook time
    func calculateBTU (){
        // default BTUs
        if preheatTime == nil {
            preheatTime = 0
        }
        
        else if settings.applianceType == "Gas"{
            settings.btuUsed = 300.0 * Float(preheatTime! + cookTime)
        }
        
        else if settings.applianceType == "Electric"{
            settings.btuUsed = 130.883925 * Float(preheatTime! + cookTime)
        }
        
        else if settings.applianceType == "Induction"{
            settings.btuUsed = 283.33333 * Float(preheatTime! + cookTime)
            
        }
        print(settings.btuUsed)
    }
    
    // calculate local percentage
    func calculateLocal() {
        var localCount = 0
        let totalIngredients = isChecked.count
        for ingredient in isChecked{
            if ingredient == true{
                localCount += 1
            }
        }
        var localPercent = (Float(localCount) / Float(totalIngredients))
        settings.localPercent = localPercent * 100
        print(settings.localPercent)
    }
   
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text(name)
                    .font(.largeTitle).bold()
                    .padding()
                
                // ingredients
                // need to figure out why ingredient arent showing up
                Text("Ingredients")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Check For Local").frame(maxWidth: .infinity, alignment: .leading)
                ForEach(ingredients.indices, id: \.self) { index in
                    let ingredient = ingredients[index]
                    VStack(alignment: .leading) {
                        Toggle(isOn: $isChecked[index]) {
                            Text("\(ingredient.quantity), \(ingredient.name), \(ingredient.prep)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 5)
                        }
                        
                        
                        
                    }.toggleStyle(CheckboxToggleStyle())
                }
                
                // Instructions
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
                
                // Notes
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
                            .background(Color(.systemGray6)) //idk fix this to look good im TIRED
                    }
                }
                Text("Oven Preheat Time")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                TextField("Enter Preheat Time", value: $preheatTime, formatter: NumberFormatter())
                Button(action: {
                    calculateBTU()
                    calculateLocal()
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
    
    // Fetch recipe details
    func fetchRecipeDetails() {
        let details = fetchRecipeDetailsFromDB(recipeId: recipeId)
        name = details.name
        instructions = details.instructions
        notes = details.notes
        ingredients = details.ingredients
        isChecked = Array(repeating: false, count: ingredients.count)
        print(isChecked)
    }
}
func fetchRecipeDetailsFromDB(recipeId: Int) -> (name: String, instructions: String, notes: String, ingredients: [(id: Int, name: String, quantity: String, prep: String)]) {
    var db: OpaquePointer?
    let dbPath = Bundle.main.path(forResource: "ClimateKitchen", ofType: "db") ?? ""
    
    if sqlite3_open(dbPath, &db) != SQLITE_OK {
        print("Failed to open database.")
        return ("", "", "", [])
    }
    
    // Query for recipe details
    var recipeQuery = "SELECT recipeName, instructions, notes FROM Recipes WHERE recipe_id = \(recipeId)"
    var recipeStatement: OpaquePointer?
    var name = ""
    var instructions = ""
    var notes = ""
    
    if sqlite3_prepare_v2(db, recipeQuery, -1, &recipeStatement, nil) == SQLITE_OK {
        if sqlite3_step(recipeStatement) == SQLITE_ROW {
            name = String(cString: sqlite3_column_text(recipeStatement, 0))
            instructions = String(cString: sqlite3_column_text(recipeStatement, 1))
            notes = String(cString: sqlite3_column_text(recipeStatement, 2))
            
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
    return (name, instructions, notes, ingredients)
}


