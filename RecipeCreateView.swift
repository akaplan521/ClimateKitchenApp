import SwiftUI
import UIKit

// Cierra: Recipe Create page
struct RecipeCreateView: View {
    //---------------------------------------------------------------------------------------
    
    
    //need to add prep and quantity for ingredients.
    
    //-----------------------------------------------------------------------------------------
    
    
    // TODO: implement logic to add buttons that allows them to be properly parsed and stored
    // TODO: implement edit recipe functionality
    @State private var recipeName = ""
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    @State private var newNotes = ""
    @State private var ingredients : [String] =  []
    @State private var instructions : [String] = []
    @State private var notes : [String] = []

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    //enter name for recipe
                    TextField("Enter Recipe Name", text: $recipeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // add ingredients
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.headline)
                        
                        ForEach(ingredients, id: \.self) { ingredient in
                            TextField("", text: .constant(ingredient))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(true)
                        }
                        
                        HStack {
                            TextField("Add an Ingredient", text: $newIngredient)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                if !newIngredient.isEmpty {
                                    ingredients.append(newIngredient)
                                    newIngredient = ""
                                }
                            }) {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }.padding()
                    
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
}
