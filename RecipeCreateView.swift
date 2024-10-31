import SwiftUI
import UIKit

// Cierra: Recipe Create page
struct RecipeCreateView: View {
    // TODO: implement logic to add buttons that allows them to be properly parsed and stored
    // TODO: implement edit recipe functionality
    @State private var recipeName = ""
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    @State private var ingredients : [String] =  []
    @State private var instructions : [String] = []

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
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
                
                Spacer()
            }
        }
        // when Done is clicked, this will redirect to recipe home and eventually save recipe info
        Button("Done") {
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
