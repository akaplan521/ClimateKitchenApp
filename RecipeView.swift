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
    @State private var fillColor = [Color.black,Color.black,Color.black,Color.black,Color.black]
    @State private var isEditing = false
    @State private var isTapped = false
    //TODO: These will get read in from database, is checked will be all set to false with length of ingredients
    @State private var isChecked = [false,false,false,false, false]
    @State private var seasonal = [true, true,true, false, false]
    
    let ingredients = [("1","Carrot"), ("2-3","Beets"),("1", "Parsnip"),("3-4 T","Olive Oil" ), ("Dash", "Salt")]
    let recipeTitle = "Roasted Root Vegetables"
    let instructions = [("1.", "Preheat the oven to 425°F."),
                        ("2.","Wash, peel and cut veggies."),
                        ("3.", "On a low-sided baking sheet, toss veggies together with salt and olive oil. Spread them out and roast until browned and tender, 25-30 minutes.")]
    
    
    // this function changes the star colors
    func changeStars(num : Int){
        if fillColor[num] == Color.black{
            for number in 0...num{
                if fillColor[number] == Color.black{
                    fillColor[number] = Color.yellow
                }
            }
        }
        else{
            for number in num...4{
                if fillColor[number] == Color.yellow{
                    fillColor[number] = Color.black
                }
            }
        }
        var ratingCount = 0
        for i in 0...4{
            if fillColor[i] == Color.yellow{
                ratingCount+=1
            }
        }
        settings.rating = ratingCount
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
                            // TODO: ingredients, centered it but can change
                            Text("Ingredients").bold().frame(maxWidth: .infinity)
                            ForEach(ingredients.indices, id: \.self) { index in
                                HStack {
                                    // Toggle check box and if ingredient is seasonal or not
                                    // TODO: change color to display image
                                    Toggle(isOn: $isChecked[index]) {
                                        if seasonal[index] == true{
                                            Text(self.ingredients[index].0)
                                            NavigationLink(destination: NutrientView()) {
                                                    Text(ingredients[index].1).foregroundColor(.green)
                                            }
                                                }
                                            else{
                                                Text(self.ingredients[index].0)
                                                NavigationLink(destination: NutrientView()) {
                                                    Text(ingredients[index].1).foregroundColor(.red)
                                                }
                                        }
                                        
                                    }.toggleStyle(CheckboxToggleStyle())
                                }
                            }
                            // TODO: Instructions, centered it but can change
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
                            
                            // sliders for users to pick
                            // TODO: difficulty, centered it but can change
                            Text("Difficulty").bold().frame(maxWidth: .infinity)
                            HStack(){
                                Text("Easy")
                                Spacer()
                                Text ("Hard")
                            }.scenePadding(.top)
                            Slider(
                                value: $settings.difficulty,
                                in: 0...5,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                    
                                }
                            )
                            // TODO: temperature, centered it but can change
                            Text("Temperature").bold().frame(maxWidth: .infinity)
                            HStack(){
                                Text("Hot")
                                Spacer()
                                Text ("Cold")
                            }.scenePadding(.top)
                            
                            Slider(
                                value: $settings.foodTemp,
                                in: 0...5,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                    
                                }
                            )
                            // TODO: Spice, centered it but can change
                            Text("Spice Level").bold().frame(maxWidth: .infinity)
                            HStack(){
                                Text("Not Spicy")
                                Spacer()
                                Text ("Spicy")
                            }.scenePadding(.top)
                            
                            Slider(
                                value: $settings.spiceLevel,
                                in: 0...5,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                    
                                }
                            )
                            Text("Click On The Food Descriptors Below and Choose the Relevant Boxes").bold().frame(maxWidth: .infinity)
                            
                            
                            NavigationLink(destination: AppearanceView().environmentObject(Settings())) {
                                Text("Appearance").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: AromaView().environmentObject(Settings())) {
                                Text("Aroma").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: FlavorView().environmentObject(Settings())) {
                                Text("Flavor").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: TextureView().environmentObject(Settings())) {
                                Text("Texture").bold().frame(maxWidth: .infinity)
                            }
                            HStack{
                                Text("Tap For Rating").bold()
                                // 1 star ranking
                                Image(systemName: "star.fill").foregroundColor(fillColor[0]).onTapGesture(count: 2) {
                                    changeStars(num:0)
                                }
                                // 2 star ranking
                                Image(systemName: "star.fill").foregroundColor(fillColor[1]).onTapGesture(count: 2) {
                                    changeStars(num:1)
                                }
                                // 3 star ranking
                                Image(systemName: "star.fill").foregroundColor(fillColor[2]).onTapGesture(count: 2) {
                                    changeStars(num:2)
                                }
                                // 4 star ranking
                                Image(systemName: "star.fill").foregroundColor(fillColor[3]).onTapGesture(count: 2) {
                                    changeStars(num:3)
                                }
                                // 5 star ranking
                                Image(systemName: "star.fill").foregroundColor(fillColor[4]).onTapGesture(count: 2) {
                                    changeStars(num : 4)
                                }
                                
                            }.frame(maxWidth:.infinity)
                            
                                                              
                            // TODO: add struct to do the math, then direct to home page
                            HStack(spacing:100){
                                // Add all the stats to profile
                                Button("I MADE THIS"){
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
    
    }
    
   
}



