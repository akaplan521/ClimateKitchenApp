//
//  ProfileView.swift
//  ProfilePage
//
//  Created by Wyatt Chrisman on 10/9/24.
//

import SwiftUI

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
            HStack {
                Spacer()
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Spacer()
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Spacer()
            }
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

// First-Time Setup Sheet
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

// Edit Profile Options View
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

// New Edit Name View
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

// Allergy Selection Sheet
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

// Location Picker Sheet
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

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
