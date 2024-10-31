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
// This view will allow user to choose from appliance type, sets type to settings
struct ApplianceView: View {
    @EnvironmentObject var settings: Settings
    @State private var applianceTypes=["Gas",
                                    "Electric",
                                    "Induction"]
    @State private var isChecked = [false,false,false]
    
    // function used to set appliance
    func setAppliance(newAppliance: Int) {
        settings.applianceType = applianceTypes[newAppliance]
    }
    var body: some View {
        Text("By choosing a appliance, the energy usage will be enabled using universal metrics. This will be represented in your profile if you choose I MADE THIS , recipe").lineSpacing(10)
            // allow user to choose appliance type
        ForEach(applianceTypes.indices, id: \.self) { index in
            HStack {
            // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                    Text(applianceTypes[index])
                    }.toggleStyle(CheckboxToggleStyle())
                    // This allows user to only click one
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue {
                            // call function to set appliance type
                            setAppliance(newAppliance: index)
                            // Uncheck others if one is checked
                            for i in isChecked.indices {
                                if i != index {
                                    isChecked[i] = false
                                }
                            }
                        }
                    }
           }
               
        }
        
        
    }
    
}

// This view will allow user to choose food appearance desciptors, and add to settings
struct Appearance: View {
    @EnvironmentObject var settings: Settings
    @State private var foodApperance = [
        (1, "Appetizing"),(2, "Attractive"),(3, "Bright"),(4, "Browned"),
        (5, "Bubbly"),(6, "Burnt"),(7, "Chunky"),(8, "Clear"),(9, "Cloudy"),(10, "Coarse"),
        (11, "Colorful"),(12, "Colorless"),(13, "Crisp"),(14, "Crumbly"),(15, "Delicate"),
        (16, "Dry"),(17, "Dull"),(18, "Fancy"),(19, "Firm"),(20, "Flaky"),(21, "Flat"),
        (22, "Fluffy"),(23, "Foamy"),(24, "Fragile"),(25, "Glossy"),(26, "Golden"),
        (27, "Greasy"),(28, "Grainy"),(29, "Hard"),(30, "Heavy"),(31, "Limp"),
        (32, "Lumpy"),(33, "Moist"),(34, "Mottled"),(35, "Mushy"),(36, "Opaque"),
        (37, "Pale"),(38, "Uniform"),(39, "Varied")]
    
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false]
    
    // function used to set appearance
    func setAppearance(a: Int) {
        if !settings.appearance.contains(foodApperance[a].1){
            settings.appearance.append(foodApperance[a].1)
        }
        
    }
    // function used to remove appearance
    func removeAppearance(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.appearance.firstIndex(where: {$0 == foodApperance[a].1}){
            settings.appearance.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Food appearance plays a crucial role in the overall dining experience, influencing our perceptions of taste, quality, and appeal.").lineSpacing(10)
         
        ForEach(0..<foodApperance.count, id: \.self) { index in
            HStack {
                if (index % 3 ) == 0{
                    // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: space the text out better
                        Text(foodApperance[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodApperance[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodApperance[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                }
            

                    
           }
               
        }
        
        
    }
    
}
// This view will allow user to choose food aroma desciptors, and add to settings
struct Armoa: View {
    @EnvironmentObject var settings: Settings
    @State private var foodAroma = [
            (1, "Acidic"),(2, "Acrid"),(3, "Bitter"),(4, "Bland"),
            (5, "Briny"),(6, "Burnt"),(7, "Citrus"),(8, "Earthy"),
            (9, "Floral"),(10, "Fruity"),(11, "Green"),(12, "Herbaceous"),
            (13, "Lemony"),(14, "Mild"),(15, "Minty"),(16, "Musty"),
            (17, "Perfumed"),(18, "Piney"),(19, "Piquant"),(20, "Pungent"),
            (21, "Rancid"),(22, "Rotten"),(23, "Savory"),(24, "Sharp"),
            (25, "Smoky"),(26, "Sulfurous"),(27, "Sweet"),(28, "Tart"),
            (29, "Weak"),(30, "Woody"),(31, "Yeasty"),(32, "Zesty"),(33, "Zingy")
    ]
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false]
    
    // function used to set aroma
    func setAroma(a: Int) {
        if !settings.aroma.contains(foodAroma[a].1){
            settings.aroma.append(foodAroma[a].1)
        }
        
    }
    // function used to remove aroma
    func removeAroma(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.aroma.firstIndex(where: {$0 == foodAroma[a].1}){
            settings.aroma.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Aroma is a vital component to our culinary experience, accounting for approximately 80% of what we perceive as flavor").lineSpacing(10)
         
        ForEach(0..<foodAroma.count, id: \.self) { index in
            HStack {
                if (index % 3) == 0{
                    // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                        Text(foodAroma[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodAroma[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodAroma[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                }
            

                    
           }
               
        }
        
        
    }
    
}
// This view will allow user to choose food Flavor desciptors, and add to settings
struct Flavor: View {
    @EnvironmentObject var settings: Settings
    
    @State private var foodFlavor = [
           (1, "Acerbic"),(2, "Acidic"),(3, "Astringent"),(4, "Bland"),
           (5, "Bitter"),(6, "Bright"),(7, "Briny"),(8, "Burnt"),(9, "Buttery"),
           (10, "Citrus"),(11, "Cool"),(12, "Creamy"),(13, "Dry"),(14, "Earthy"),
           (15, "Fatty"),(16, "Fresh"),(17, "Fruity"),(18, "Grassy"),(19, "Heavy"),
           (20, "Light"),(21, "Meaty"),(22, "Mellow"),(23, "Metallic"),(24, "Mild"),
           (25, "Nutty"),(26, "Plain"),(27, "Rancid"),(28, "Rich"),(29, "Peppery"),
           (30, "Saccharine"),(31, "Saline"),(32, "Salty"),(33, "Savory"),(34, "Sharp"),
           (35, "Smoky"),(36, "Sour"),(37, "Spicy"),(38, "Stale"),(39, "Sweet"),(40, "Tangy"),
           (41, "Tart"),(42, "Vegetal"),(43, "Yeasty"),(44, "Zesty")]
    
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false,  false]
    
    // function used to set flavor
    func setFlavor(a: Int) {
        if !settings.flavor.contains(foodFlavor[a].1){
            settings.flavor.append(foodFlavor[a].1)
        }
        
    }
    // function used to remove flavor
    func removeFlavor(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.flavor.firstIndex(where: {$0 == foodFlavor[a].1}){
            settings.flavor.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Food flavor is a multifaceted phenomenon that arises from the intricate combination of taste, smell, and texture.").lineSpacing(10)
         
        ForEach(0..<foodFlavor.count, id: \.self) { index in
            HStack {
            // Toggle check box
                if (index % 2) == 0{
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: spacing the text out better
                        Text(foodFlavor[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set flavor string
                            setFlavor(a: index)
                        }
                        if newValue == false{
                            // call function to delete flavor string
                            removeFlavor(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodFlavor[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set flavor string
                            setFlavor(a: index)
                        }
                        if newValue == false{
                            // call function to delete flavor string
                            removeFlavor(a: index)
                        }
                    }
                }
                    

                    
           }
               
        }
        
        
    }
    
}
// This view will allow user to choose food texture desciptors, and add to settings
struct Texture: View {
    @EnvironmentObject var settings: Settings
    @State private var foodTexture = [
            (1, "Bouncy"),(2, "Brittle"),(3, "Bubbly"),(4, "Chewy"),
            (5, "Chunky"),(6, "Coarse"),(7, "Crispy"),(8, "Crumbly"),
            (9, "Crunchy"),(10, "Crusty"),(11, "Dry"),(12, "Elastic"),
            (13, "Fibrous"),(14, "Firm"),(15, "Fizzy"),(16, "Flaky"),
            (17, "Fleshy"),(18, "Fluffy"),(19, "Foamy"),(20, "Gooey"),
            (21, "Greasy"),(22, "Grainy"),(23, "Gritty"),(24, "Juicy"),
            (25, "Lumpy"),(26, "Mealy"),(27, "Moist"),(28, "Mushy"),
            (29, "Pulpy"),(30, "Powdery"),(31, "Rubbery"),(32, "Runny"),
            (33, "Sandy"),(34, "Silky"),(35, "Slimy"),(36, "Smooth"),
            (37, "Soft"),(38, "Soggy"),(39, "Soupy"),(40, "Spongy"),
            (41, "Springy"),(42, "Starchy"),(43, "Sticky"),(44, "Stiff"),
            (45, "Tender"),(46, "Tough"),(47, "Velvety"),(48, "Waxy")]
   
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false,  false,false,false,
                                    false,  false, false]
    
    // function used to set texture
    func setTexture(a: Int) {
        if !settings.texture.contains(foodTexture[a].1){
            settings.texture.append(foodTexture[a].1)
        }
        
    }
    // function used to remove texture
    func removeTexture(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.texture.firstIndex(where: {$0 == foodTexture[a].1}){
            settings.texture.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Texture is not about tase, it's the mouth feel we percieve when we are eating. Texture is a vital component that can make or break our satisfaction with a dish").lineSpacing(10)
         
        ForEach(0..<foodTexture.count, id: \.self) { index in
            HStack {
            // Toggle check box
                if(index % 3) == 0 {
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: spacing the text out better
                        Text(foodTexture[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodTexture[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodTexture[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    
                }
                    

           }
               
        }
        
        
    }
    
}
// This view will allow user to view nutrient facts of given ingredient
// TODO: add sql statement to pull facts
struct NutrientView: View {
    var home : RecipeView!
    // TODO: Nutrition for this Ingredient
    var body: some View {
        Text("FACTS").lineSpacing(10)
    }
}

struct RecipeView: View {
    @EnvironmentObject var settings: Settings
    @State private var isEditing = false
    //TODO: These will get read in from database, is checked will be all set to false with length of ingredients
    @State private var isChecked = [false,false,false,false, false]
    let ingredients = [("1","Carrot"), ("2-3","Beets"),("1", "Parsnip"),("3-4 T","Olive Oil" ), ("Dash", "Salt")]
    let recipeTitle = "Roasted Root Vegetables"
    @State private var sesonal = [true, true,true, false, false]
    let instructions = [("1.", "Preheat the oven to 425°F."),
                        ("2.","Wash, peel and cut veggies."),
                        ("3.", "On a low-sided baking sheet, toss veggies together with salt and olive oil. Spread them out and roast until browned and tender, 25-30 minutes.")]
   
    
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
                            
                            
                            NavigationLink(destination: Appearance().environmentObject(Settings())) {
                                Text("Appearance").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: Armoa().environmentObject(Settings())) {
                                Text("Aroma").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: Flavor().environmentObject(Settings())) {
                                Text("Flavor").bold().frame(maxWidth: .infinity)
                            }
                            
                            
                            NavigationLink(destination: Texture().environmentObject(Settings())) {
                                Text("Texture").bold().frame(maxWidth: .infinity)
                            }
                            
                            
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
            BottomNavigationBar()
        }
    
    }
    
   
}

#Preview {
    RecipeView().environmentObject(Settings())
        
}

