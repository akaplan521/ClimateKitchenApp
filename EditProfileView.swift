//
//  EditProfileView.swift
//  CC-All
//
//  Created by Wyatt Chrisman on 11/11/24.
//

import SwiftUI

// Edit Profile Sheet
struct EditProfileView: View {
    @Binding var name: String
    @Binding var selectedCity: String
    @Binding var selectedAllergies: [String]
    
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode

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
                    TextField("Enter your location", text: $selectedCity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    List(filteredCities, id: \.self) { city in
                        Button(action: {
                            selectedCity = city
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
                    if !name.isEmpty && !selectedCity.isEmpty {
                        presentationMode.wrappedValue.dismiss()
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
            .navigationTitle("Edit Your Profile")
        }
    }
}
