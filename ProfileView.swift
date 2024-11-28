//
//  ProfileView.swift
//  ProfilePage
//
//  Created by Wyatt Chrisman on 10/9/24.
//

import SwiftUI
import SQLite3

struct ProfileView: View {
    @State private var showSetupSheet = true
    @State private var showSettingsViewSheet = false
    @State private var showEditProfileSheet = false
    
    @State var name: String
    @State var selectedCity: String
    @State var selectedAllergies: [String]
    @State var isSignedIn: Bool
    
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
                
                Text(selectedCity)
                    .font(.title3)
                    .foregroundColor(selectedCity == "" ? .red : .primary)
                    .padding(.top, 5)
            }
            
            // Edit Profile Button
            VStack(spacing: 20) {
                Button(action: {
                    // Show edit profile options
                    showSettingsViewSheet.toggle()
                }) {
                    Text("Settings")
                        .font(.headline)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showSettingsViewSheet) {
                    RootView()
                }
                
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
                    EditProfileView(
                        name: $name,
                        selectedCity: $selectedCity,
                        selectedAllergies: $selectedAllergies
                    )
                }
            }
            .padding(.top, 20)

            Spacer()
            
            // Bottom navigation bar
            // BottomNavigationBar()
        }
        .background(Color(UIColor.systemGray6)) // Background color
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showSetupSheet, onDismiss: {
            // Ensure that all details are filled before allowing the user to proceed
            if !isSignedIn  {
                showSetupSheet = true
                if name.isEmpty || selectedCity.isEmpty {
                    showSetupSheet = false
                    showEditProfileSheet = true
                }
            }
        }) {
            RootView()
        }
    }
}


// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "", selectedCity: "", selectedAllergies: [], isSignedIn: false)
    }
}
