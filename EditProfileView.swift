//
//  EditProfileView.swift
//  CC-All
//
//  Created by Wyatt Chrisman on 11/11/24.
//

import SwiftUI
import SQLite3
import FirebaseAuth


struct EditProfileView: View {
    @Binding var name: String
    @Binding var selectedCity: String
    @Binding var selectedAllergies: [String]
    
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    let usCities = ["Burlington, VT", "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ", "Denver, CO", "Miami, FL"]
    let allergies_and_preferences = ["None", "Vegetarian", "Vegan", "Peanuts", "Gluten", "Dairy", "Eggs", "Tree Nuts", "Shellfish", "Fish", "Soy"]
    
    var filteredCities: [String] {
        searchText.isEmpty ? [] : usCities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Name
                Section(header: Text("Name")) {
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.words)
                }
                
                // Location
                Section(header: Text("Location")) {
                    TextField("Search for your city", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if !filteredCities.isEmpty {
                        List(filteredCities, id: \.self) { city in
                            Button(action: {
                                selectedCity = city
                                searchText = ""
                            }) {
                                Text(city)
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(maxHeight: 150)
                    }
                    
                    if !selectedCity.isEmpty {
                        Text("Selected City: \(selectedCity)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Allergies & Dietary
                Section(header: Text("Allergies & Dietary Preferences")) {
                    ForEach(allergies_and_preferences, id: \.self) { allergy in
                        Toggle(isOn: Binding(
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
                                    selectedAllergies.removeAll { $0 == "None" }
                                } else {
                                    selectedAllergies.removeAll { $0 == allergy }
                                }
                            }
                        )) {
                            Text(allergy)
                        }
                    }
                }
                
                // Done Button
                Section {
                    Button(action: {
                        if !name.isEmpty && !selectedCity.isEmpty {
                            let uid = Auth.auth().currentUser?.uid ?? ""
                                            DatabaseManager.shared.saveUserData(
                                                uid: uid,
                                                name: name,
                                                location: selectedCity,
                                                allergies: selectedAllergies
                                            )
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .onAppear {
                    loadUserData()
                }
            
            }
            .navigationTitle("Edit Profile")
        }
    }
    private func loadUserData() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        if let userData = DatabaseManager.shared.loadUserData(uid: uid) {
            self.name = userData.name
            self.selectedCity = userData.location
            self.selectedAllergies = userData.allergies
        }
    }
}


    
struct EditProfileView_Previews: PreviewProvider {
    @State static var previewName = ""
    @State static var previewCity = ""
    @State static var previewAllergies: [String] = [""]
    static var previews: some View {
        EditProfileView(
            name: $previewName,
            selectedCity: $previewCity,
            selectedAllergies: $previewAllergies
        )
    }
}


