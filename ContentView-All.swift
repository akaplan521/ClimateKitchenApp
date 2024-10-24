//
//  ContentView.swift
//  Climate Kitchen
//
//  Created on 10/10/24.
//

import SwiftUI
import UIKit


struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

// Catie: Home page
struct HomeView: View {
    let currentDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                // Date
                Text("\(currentDate.formatted(date: .complete, time: .omitted))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                // Seasonal Inspiration
                VStack(spacing: 20) {
                    Text("Seasonal Inspiration")
                        .font(.system(size: 30, weight: .bold))
                    
                    // Recipe Buttons
                    VStack(spacing: 15) {
                        Button("Winter Squash Risotto with Sage") {
                            // action
                        }
                        .buttonStyle(SIButtonStyle())
                        
                        Button("Vinaigrette") {
                            // action
                        }
                        .buttonStyle(SIButtonStyle())
                        
                        Button("Garden Salad") {
                            // action
                        }
                        .buttonStyle(SIButtonStyle())
                        
                        Button("Cacio e Pepe Pasta") {
                            // action
                        }
                        .buttonStyle(SIButtonStyle())
                        
                        Button("Roasted Root Vegetables") {
                            // action
                        }
                        .buttonStyle(SIButtonStyle())
                    }
                    .padding(.bottom, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Little info section
                VStack {
                    Text("This app was designed to be...")
                        .font(.footnote)
                        .padding(.bottom, 10)
                    
                    // Button to About CK
                    NavigationLink(destination: AboutUsView().navigationBarBackButtonHidden(true)) {
                        Text("About Us")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                }
                
                BottomNavigationBar()
            }
            //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

// Catie: About CK page
struct AboutUsView: View {
    var body: some View {
            VStack (){
                // Title
                Text("About Climate Kitchen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                ScrollView {
                    // Image of CK mockup
                    Image(uiImage: UIImage(named: "climatekitchenmockup")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    // Additional Info Sections
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("5 Tenets of Sustainability")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Tenet One: Plant Forward – assessing macro-micronutrient quality, experimenting with new plant and insect protein sources, enhancing culinary techniques.\nTenet Two: Integrating Tastes and Habits– documenting eating preferences across various populations; building alternative foods that respond to sensory preferences.\nTenet Three: Low Waste – designing waste out of food transformations (processing, preserving, cooking); alternative packaging and preservation systems.\nTenet Four: Whole Food Utilization – using entire ingredients; promoting nutrient dense whole foods.\nTenet Five: Regional/Local Sourcing – addressing the opportunities and barriers of seasonality. ")
                                .font(.body)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Team")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Details about the team...")
                                .font(.body)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Equipment")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Details about the equipment...")
                                .font(.body)
                        }
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    
                    // Button to local options
                    NavigationLink(destination: LocallySourcedOptionsView().navigationBarBackButtonHidden(true)) {
                        Text("Locally-Sourced Options")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                }
                
                BottomNavigationBar()
            }
            //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
            .edgesIgnoringSafeArea(.all)
        }
}

// Catie: Local options page
struct LocallySourcedOptionsView: View {
    var body: some View {
        VStack {
            // Title
            Text("Locally-Sourced Options")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            // Market info
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Market #1")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 4 miles")
                        Text("Hours: Monday 8-5\nTuesday 8-5\nWednesday 8-9\n...")
                    }
                    
                    Group {
                        Text("Market #2")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 9 miles")
                        Text("Hours: Monday 7-10\nTuesday 8-11\nWednesday 8-10\n...")
                    }
                    
                    Group {
                        Text("Market #3")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 146 miles")
                        Text("Hours: Monday 1-5\nTuesday 3-5\nWednesday 11-3\n...")
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            
            BottomNavigationBar()
        }
        //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
        .edgesIgnoringSafeArea(.all)
    }
}

// Catie: Bottom menu bar
struct BottomNavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            // Home
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                Image(systemName: "house.fill")
                    .foregroundColor(.black)
            }
            Spacer()
            // Search
            NavigationLink(destination: SearchView().navigationBarBackButtonHidden(true)) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
            }
            Spacer()
            // Recipe
            NavigationLink(destination: RecipeHomeView().navigationBarBackButtonHidden(true)) {
                Image(systemName: "book.fill")
                    .foregroundColor(.black)
            }
            Spacer()
            // Profile
            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                Image(systemName: "person.fill")
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .frame(maxWidth: .infinity)
    }
}

// Catie: Seasonal inspiration recipe buttons
struct SIButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
    }
}

// Alexa: temp cause might have dif vars
struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let info: String
}

// Alexa: Search page
struct SearchView: View {
    @State var searchText = ""
    var ingredients: [Ingredient] = [
        Ingredient(name: "Carrot", info: "blah carrot"),
        Ingredient(name: "Tomato", info: "blah tomato"),
        Ingredient(name: "Lettuce", info: "blah lettuce"),
        //fake data will be from db once setup
    ]
    //show only ingredients with substring that was searched. not the functionality we want but is fine for now.
    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        }
        else {
            return ingredients.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                //search Bar
                TextField("Search for ingredients...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                //display results as clickable buttons
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredIngredients.indices, id: \.self) { index in
                            NavigationLink(destination: IngredientDetailView(ingredient: filteredIngredients[index])) {
                                Text(filteredIngredients[index].name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(index == 0 ? Color(.systemBlue).opacity(0.3) : Color(.systemGray5))
                                    .cornerRadius(10)
                                    .foregroundColor(.black) // Ensures text is visible
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                BottomNavigationBar()
            }
            .navigationTitle("Search Ingredients")
        }
    }
}

struct IngredientDetailView: View {
    let ingredient: Ingredient

    var body: some View {
        VStack {
            Text(ingredient.name)
                .font(.largeTitle)
                .padding()

            Text(ingredient.info)
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("Ingredient Info")
    }
}

// Abi: how to make a check box https://www.appcoda.com/swiftui-checkbox/
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

// Cierra: Recipe Home page
struct RecipeHomeView: View {
    @State private var showRecipeCreateView = false
    @State private var showRecipeView = false
    
    var body: some View {
        NavigationStack() {
            VStack() {
                
                // Button to Create Recipe page
                NavigationLink(destination: RecipeCreateView().navigationBarBackButtonHidden(true)) {
                    Text("Create a Recipe")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                // Button to View a Recipe
                NavigationLink(destination: RecipeView().navigationBarBackButtonHidden(true)) {
                    Text("View Recipes")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
        BottomNavigationBar()
    }
}

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

// Abi: Appliances page
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

// Nutrition facts page
struct NutrientView: View {
    var home : ContentView!
    // TODO: Nutrition for this Ingredient
    var body: some View {
        Text("FACTS").lineSpacing(10)
    }
}

// Abi: Recipe page
struct RecipeView: View {
    
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
            //BottomNavigationBar()
            }
            
        }
        

    }
    
   
}

// Wyatt: Profile page
struct ProfileView: View {
    @State private var showSetupSheet = true
    @State private var showEditProfileSheet = false
    @State private var name = ""
    @State private var selectedLocation = "Select a City"
    @State private var selectedAllergies: [String] = []
    
    var body: some View {
        VStack {
            Spacer()
            
            // Profile image and name
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.top, 20)
                
                Text(name.isEmpty ? "Name" : name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(selectedLocation)
                    .font(.title3)
                    .foregroundColor(selectedLocation == "Select a City" ? .red : .primary)
                    .padding(.top, 5)
            }
            
            // Edit Profile Button
            VStack(spacing: 20) {
                Button(action: {
                    // Show edit profile options
                    showEditProfileSheet.toggle()
                }) {
                    Text("Edit Profile")
                        .font(.headline)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showEditProfileSheet) {
                    EditProfileOptionsView(name: $name, selectedLocation: $selectedLocation, selectedAllergies: $selectedAllergies)
                }
            }
            .padding(.top, 40)
            
            // Food Miles and Local Food percentage
            HStack(spacing: 40) {
                VStack {
                    Image(systemName: "speedometer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    
                    Text("Food Miles")
                        .font(.caption)
                        .padding(.top, 5)
                }
                
                VStack {
                    Image(systemName: "speedometer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    
                    Text("% Local Food")
                        .font(.caption)
                        .padding(.top, 5)
                }
            }
            .padding(.top, 50)
            
            Spacer()
            
            // Bottom navigation bar
            BottomNavigationBar()
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGray6)) // Background color
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showSetupSheet, onDismiss: {
            // Ensure that all details are filled before allowing the user to proceed
            if name.isEmpty || selectedLocation == "Select a City"  {
                showSetupSheet = true
            }
        }) {
            FirstTimeSetupView(name: $name, selectedLocation: $selectedLocation, selectedAllergies: $selectedAllergies)
        }
    }
}

// Wyatt: First-Time Setup Sheet
struct FirstTimeSetupView: View {
    @Binding var name: String
    @Binding var selectedLocation: String
    @Binding var selectedAllergies: [String]
    
    @State private var searchText = ""
    
    let usCities = ["Burlington, VT", "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ", "Denver, CO", "Miami, FL"]
    let allergies = ["None", "Peanuts", "Tree Nuts", "Gluten", "Dairy", "Eggs", "Shellfish", "Fish", "Soy"]
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return usCities
        } else {
            return usCities.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Name Entry
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Location Entry
                VStack {
                    TextField("Enter your location", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    List(filteredCities, id: \.self) { city in
                        Button(action: {
                            selectedLocation = city
                            searchText = city
                        }) {
                            Text(city)
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                // Allergies Selection
                VStack {
                    Text("Select any allergies:")
                        .font(.headline)
                        .padding(.top)
                    
                    List(allergies, id: \.self) { allergy in
                        Toggle(allergy, isOn: Binding(
                            get: {
                                if allergy == "None" {
                                    return selectedAllergies.isEmpty
                                } else {
                                    return selectedAllergies.contains(allergy)
                                }
                            },
                            set: { newValue in
                                if allergy == "None" {
                                    if newValue {
                                        selectedAllergies.removeAll()
                                    }
                                } else if newValue {
                                    selectedAllergies.append(allergy)
                                } else {
                                    selectedAllergies.removeAll { $0 == allergy }
                                }
                            }
                        ))
                    }
                }
                
                // Done Button
                Button(action: {
                    if !name.isEmpty && selectedLocation != "Select a City" {
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }) {
                    Text("Done")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Complete Your Profile")
        }
    }
}

// Wyatt: Edit Profile Options View
struct EditProfileOptionsView: View {
    @Binding var name: String
    @Binding var selectedLocation: String
    @Binding var selectedAllergies: [String]
    
    @State private var showNameSheet = false
    @State private var showLocationSheet = false
    @State private var showAllergySheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Edit Name Button
                Button(action: {
                    showNameSheet.toggle()
                }) {
                    Text("Edit Name")
                        .font(.headline)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showNameSheet) {
                    EditNameView(name: $name)
                }
                
                // Edit Location Button
                Button(action: {
                    showLocationSheet.toggle()
                }) {
                    Text("Edit Location")
                        .font(.headline)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showLocationSheet) {
                    LocationPickerView(selectedLocation: $selectedLocation)
                }
                
                // Edit Allergies Button
                Button(action: {
                    showAllergySheet.toggle()
                }) {
                    Text("Edit Allergies")
                        .font(.headline)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showAllergySheet) {
                    AllergySelectionView(selectedAllergies: $selectedAllergies)
                }
                
                Spacer()
            }
            .navigationTitle("Edit Profile")
        }
    }
}

// Wyatt: New Edit Name View
struct EditNameView: View {
    @Binding var name: String
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // Close the sheet
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                }) {
                    Text("Done")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Edit Name")
        }
    }
}

// Wyatt: Allergy Selection Sheet
struct AllergySelectionView: View {
    @Binding var selectedAllergies: [String]
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    let allergies = ["None", "Peanuts", "Tree Nuts", "Gluten", "Dairy", "Eggs", "Shellfish", "Fish", "Soy"]
    
    var body: some View {
        NavigationView {
            List(allergies, id: \.self) { allergy in
                Toggle(allergy, isOn: Binding(
                    get: {
                        if allergy == "None" {
                            return selectedAllergies.isEmpty
                        } else {
                            return selectedAllergies.contains(allergy)
                        }
                    },
                    set: { newValue in
                        if allergy == "None" {
                            if newValue {
                                selectedAllergies.removeAll()
                            }
                        } else if newValue {
                            selectedAllergies.append(allergy)
                        } else {
                            selectedAllergies.removeAll { $0 == allergy }
                        }
                    }
                ))
            }
            .navigationTitle("Select Allergies")
            .navigationBarItems(trailing: Button("X") {
                presentationMode.wrappedValue.dismiss() // Dismiss the sheet
            })
        }
    }
}

// Wyatt: Location Picker Sheet
struct LocationPickerView: View {
    @Binding var selectedLocation: String
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    
    let usCities = ["Burlington, VT", "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ", "Denver, CO", "Miami, FL"]
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return usCities
        } else {
            return usCities.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Display current location
                Text("Current Location: \(selectedLocation)")
                    .font(.headline)
                    .padding(.top)
                
                // Text field for searching cities
                TextField("Enter your location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // List of filtered cities
                List(filteredCities, id: \.self) { city in
                    Button(action: {
                        selectedLocation = city  // Update selectedLocation
                        searchText = city        // Show selected city in the search field
                    }) {
                        Text(city)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Select Location")
            .navigationBarItems(trailing: Button("X") {
                presentationMode.wrappedValue.dismiss() // Dismiss the sheet
            })
        }
    }
}


#Preview {
    ContentView()
}
