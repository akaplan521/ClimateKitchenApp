import SwiftUI
import UIKit

struct RecipeCreateView: View {
    //---------------------------------------------------------------------------------------
    
    // TODO: add functions to call sql queries for storing in recipe db; 
    //first well use it to create recipe/ingredient join table, then well have to change it to connect to user profiles
    // TODO: implement edit recipe functionality
    @State private var recipeName = ""
    @State private var newIngredient = ""
    @State private var ingredientQuantity = ""
    @State private var ingredientPrep = ""
    @State private var ingredientFdcId = ""
    @State private var newInstruction = ""
    @State private var newNotes = ""
    @State private var ingredients : [[String]] =  []
    @State private var instructions : [String] = []
    @State private var notes : [String] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 20) {
                //enter name for recipe
                VStack(alignment: .leading) {
                    Text("Recipe Name")
                        .font(.headline)
                        .padding(.bottom, 5) //optional spacing below the label

                    TextField("Enter Recipe Name", text: $recipeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal) //align with other sections
                
                ScrollView{
                    // add ingredients
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 5) //pptional spacing below the label
                        
                        
                        //displaying added ingredients as list
                        ForEach(ingredients.indices, id: \.self) { index in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Ingredient: \(ingredients[index][1])")
                                    Text("Quantity: \(ingredients[index][0])")
                                    Text("Prep: \(ingredients[index][2])")
                                }
                                Spacer()
                                Button(action: {
                                    ingredients.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        
                        //inputting
                        HStack(alignment: .top) {
                            TextField("Quantity", text: $ingredientQuantity)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 80)
                            
                            //ingredient Search
                            ZStack {
                                VStack {
                                    SearchIngredientView(
                                        selectedIngredient: $newIngredient,
                                        selectedFdcId: $ingredientFdcId,
                                        searchText: $newIngredient // bound to newIngredient to sync text
                                        
                                    )
                                }
                                .frame(height: 150) //limit height to keep it compact when displaying results
                            }
                            .frame(width: 200) //align the width of the search field with others
                            
                            TextField("Prep ⃰", text: $ingredientPrep)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 60)
                            
                            Button(action: addIngredient) {
                                Image(systemName: "plus.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                    }.padding(.horizontal)
                    
                    // add instructions
                    VStack(alignment: .leading) {
                        Text("Instructions")
                            .font(.headline)
                        
                        ForEach(0 ..< instructions.count, id: \.self) { index in
                            HStack(alignment: .top) {
                                Text("\(index + 1).")
                                    .bold()
                                TextField("", text: .constant(instructions[index]))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)
                                Spacer()
                                Button(action: {
                                    instructions.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        HStack {
                            TextField("Add an Instruction", text: $newInstruction)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                if !newInstruction.isEmpty {
                                    instructions.append(newInstruction)
                                    newInstruction = ""
                                }
                            }) {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }.padding()
                    
                    // add notes
                    VStack(alignment: .leading) {
                        Text("Notes")
                            .font(.headline)
                        
                        ForEach(0 ..< notes.count, id: \.self) { index in
                            HStack(alignment: .top) {
                                Text("\(index + 1).")
                                    .bold()
                                TextField("", text: .constant(notes[index]))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)
                                Spacer()
                                Button(action: {
                                    notes.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        HStack {
                            TextField("Add an Instruction", text: $newNotes)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                if !newNotes.isEmpty {
                                    notes.append(newNotes)
                                    newNotes = ""
                                }
                            }) {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }.padding()
                    
                    Spacer()
                    Spacer()
                }}
        }
        // when Done is clicked, this will redirect to recipe home and eventually save recipe info
        Button("Done") {
            //Call function for adding recipe to sql
            dismiss()
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.2))
        .foregroundColor(.black)
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .padding(.bottom, 20)
    }
    
    func addIngredient() {
        guard !ingredientQuantity.isEmpty && !newIngredient.isEmpty else { return }
        
        //add to ingredients array ; allow prep to be empty and set as empty string
        ingredients.append([ingredientQuantity, newIngredient, ingredientPrep.isEmpty ? "" : ingredientPrep, ingredientFdcId])
        
        //clear input fields
        ingredientQuantity = ""
        newIngredient = ""
        ingredientPrep = ""
        ingredientFdcId = ""
    }
    
}


