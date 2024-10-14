//
//  ContentView.swift
//  Climate Kitchen
//
//  Created by Catherine Crowell on 10/10/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

// Home page
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
            .background(Color(red: 241/255, green: 230/255, blue: 218/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

// About CK page
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
            .background(Color(red: 241/255, green: 230/255, blue: 218/255))
            .edgesIgnoringSafeArea(.all)
        }
}

// Local options page
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
        .background(Color(red: 241/255, green: 230/255, blue: 218/255))
        .edgesIgnoringSafeArea(.all)
    }
}

// Bottom menu bar
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
            Button(action: {
                // Action
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
            }
            Spacer()
            // Recipe
            Button(action: {
                // Action
            }) {
                Image(systemName: "book.fill")
                    .foregroundColor(.black)
            }
            Spacer()
            // Profile
            Button(action: {
                // Action
            }) {
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

// Seasonal inspiration recipe buttons
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

#Preview {
    ContentView()
}
