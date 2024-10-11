//
//  ContentView.swift
//  ContextView
//
//  Created by awrigh30on 10/9/24.
//

import SwiftUI
import UIKit

// how to make a check box https://www.appcoda.com/swiftui-checkbox/
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
struct ApplianceView: View {
    // TODO: This will need to be figured out: type of appliances, only allow one button
    let applianceType = ["Gas", "Electric","Induction"]
    @State private var isChecked = [false,false,false]
    @State private var countChecked = 0
    var body: some View {
        Text("By choosing a appliance, the energy usage will be enabled using universal metrics. This will be represented in your profile if you choose I MADE THIS , recipe").lineSpacing(10)
        ForEach(applianceType.indices, id: \.self) { index in
            // allow user to choose appliance type
            HStack {
                if countChecked == 0{
                    Toggle(isOn: $isChecked[index]) {
                        Text(self.applianceType[index])
                        
                    }.toggleStyle(CheckboxToggleStyle())
                }
                    
            }
        }
        
    }
}
struct NutrientView: View {
    var home : ContentView!
    // TODO: Nutrition for this Ingredient
    var body: some View {
        Text("FACTS").lineSpacing(10)
    }
}
struct ContentView: View {
    
    @State private var value = 0
    static var MAXVAL = 5
    @State  var useRed = false
    
    //TODO: These will get read in from database, is checked will be all set to false with length of ingredients
    @State private var isChecked = [false,false,false,false, false]
    let ingredients = [("1","Carrot"), ("2-3","Beets"),("1", "Parsnip"),("3-4 T","Olive Oil" ), ("Dash", "Salt")]
    let recipeTitle = "Roasted Root Vegetables"
    @State private var sesonal = [true, true,true, false, false]
    let instructions = [("1.", "Preheat the oven to 425°F."),("2.","Wash, peel and cut veggies."),("3.", "On a low-sided baking sheet, toss veggies together with salt and olive oil. Spread them out and roast until browned and tender, 25-30 minutes.")]
    
    var body: some View {
        NavigationStack {
        VStack() {
            Text(recipeTitle).font(.largeTitle)
            VStack{
                // TODO: Enter Image
                HStack(){
                    // Show ingredients and instructions in list view
                    List {
                        ForEach(ingredients.indices, id: \.self) { index in
                            HStack {
                                // Toggle check box and if ingredient is seasonal or not
                                Toggle(isOn: $isChecked[index]) {
                                    if sesonal[index] == true{
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
                        
                        ForEach(instructions.indices, id: \.self) { index in
                            // if instrucstions contain over, but can be other appliances
                            // allow user to choose appliance type
                            HStack {
                                if instructions[index].1.contains("oven"){
                                    Text(self.instructions[index].0)
                                    Text(self.instructions[index].1)
                                    NavigationLink(destination: ApplianceView()) {
                                                        Text("Appliance Type")
                                                    }
                                                    
                                }
                                else {
                                    Text(self.instructions[index].0)
                                    Text(self.instructions[index].1)
                                }
                                
                            }
                        }
                        
                        HStack(spacing:100){
                            // Add all the stats to profile
                            Button("I MADE THIS"){
                                
                            }
                            // Add to Database like or dislike
                            Button("Like"){
                                
                            }
                            Button("Dislike"){
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
            }
            }
            
        }
        

    }
    
   
}

#Preview {
    ContentView()
        
}

