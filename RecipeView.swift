//
//  RecipeView.swift
//  RecipeView
//  Created by awrigh30on 10/9/24.
//

import SwiftUI
import UIKit

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


struct RecipeView: View {
    @EnvironmentObject var settings: Settings
    @State private var showReviewView = false
    @State private var seasonal = [true, true,true, false, false]
    @State private var fillColor = [Color.black,Color.black,Color.black,Color.black,Color.black]
    @State private var isEditing = false
    @State private var isTapped = false
    @State private var preheatTime: Int?
    @State private var isChecked = [false,false,false,false, false]
    
    let ingredients = [("1","Carrot"), ("2-3","Beets"),("1", "Parsnip"),("3-4 T","Olive Oil" ), ("Dash", "Salt")]
    let recipeTitle = "Roasted Root Vegetables"
    let prepTime = 20
    let cookTime = 30
    let instructions = [("1.", "Preheat the oven to 425°F."),
                        ("2.","Wash, peel and cut veggies."),
                        ("3.", "On a low-sided baking sheet, toss veggies together with salt and olive oil. Spread them out and roast until browned and tender, 25-30 minutes.")]
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
        
        NavigationStack {
            VStack() {
                Text(recipeTitle).font(.largeTitle)
                VStack{
                    HStack(){
                        // Show ingredients and instructions in list view
                        List {
                            // insert image
                            Image(uiImage: UIImage(named: "roasted_root.jpg")!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding()
                            // ingredients, centered it but can change
                            Text("Ingredients").bold().frame(maxWidth: .infinity)
                            ForEach(ingredients.indices, id: \.self) { index in
                                HStack {
                                    // Toggle check box and if ingredient is seasonal or not
                                    // TODO: change color to display image
                                    Toggle(isOn: $isChecked[index]) {
                                        if seasonal[index] == true{
                                            Text(self.ingredients[index].0)
                                            NavigationLink(destination: NutrientView()) {
                                                    Text(ingredients[index].1)
                                            }
                                                }
                                            else{
                                                Text(self.ingredients[index].0)
                                                NavigationLink(destination: NutrientView()) {
                                                    Text(ingredients[index].1)
                                                }
                                        }
                                        
                                    }.toggleStyle(CheckboxToggleStyle())
                                }
                            }
                            
                            // instructions, centered it but can change
                            Text("Instructions").bold().frame(maxWidth: .infinity)
                            ForEach(instructions.indices, id: \.self) { index in
                                // if instrucstions contain oven or stove, but can be other appliances
                                // allow user to choose appliance type
                                HStack {
                                    if instructions[index].1.contains("oven") || instructions[index].1.contains("stove") {
                                        Text(self.instructions[index].0)
                                        Text(self.instructions[index].1)
                                        NavigationLink(destination: ApplianceView().environmentObject(Settings())) {
                                            Text("Appliance Type")
                                        }
                                        
                                    }
                                    // if it doesnt have the key word oven or stove
                                    else {
                                        Text(self.instructions[index].0)
                                        Text(self.instructions[index].1)
                                    }
                                    
                                }
                            }
                            TextField("Oven Preheat Time", value: $preheatTime, formatter: NumberFormatter())

                            
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
                }
            }
            
        }
    
    }
    
   
}



