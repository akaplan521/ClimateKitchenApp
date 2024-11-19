import SwiftUI
import UIKit

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
                            Text("General Information")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("The core UVM Climate Kitchen faculty and researchers have a long history of success in research funding, curriculum development, and published scholarly works. Our focus is on creating opportunities for broader collaboration, partnerships, funding and support. The Climate Kitchen is funded in part the UVM Food Systems Research Center.")
                                .font(.body)
                        }
                        .padding()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("5 Tenets of Sustainability")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Tenet One: Plant Forward – assessing macro-micronutrient quality, experimenting with new plant and insect protein sources, enhancing culinary techniques.\n\nTenet Two: Integrating Tastes and Habits– documenting eating preferences across various populations; building alternative foods that respond to sensory preferences.\n\nTenet Three: Low Waste – designing waste out of food transformations (processing, preserving, cooking); alternative packaging and preservation systems.\n\nTenet Four: Whole Food Utilization – using entire ingredients; promoting nutrient dense whole foods.\n\nTenet Five: Regional/Local Sourcing – addressing the opportunities and barriers of seasonality. ")
                                .font(.body)
                        }
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Team")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("\nAmy B. Trubek - Director")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("Dr. Trubek is Professor of Nutrition and Food Sciences and the founding faculty director of the Food Systems Graduate Program. She will oversee integrating the design of the Climate Kitchen with research and pedagogical goals around food and climate change.")
                                .font(.body)
                            Text("\nCynthia Belliveau - Research and Pedagogy Director")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("The former Dean of Continuing and Distance Education and Research Faculty Emerita in Nutrition and Food Sciences, she will advise the team on techniques for emergent research and pedagogy to address food and climate change. She will oversee the renovation and identity development of the Kitchen.")
                                .font(.body)
                            Text("\nAlec Adams - Project Advisor")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("Alec is the Assistant Dean of Administration and Finance at the Grossman School of Business. He will advise the team on the design of the Climate Kitchen and facilitate the renovation process.")
                                .font(.body)
                            Text("\nEmily Barbour - Project Manager")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("Emily coordinates all the activities in the Nutrition and Food Sciences Foods Lab. She will manage the implementation of the Climate Kitchen.")
                                .font(.body)
                            Text("\nAmy Finley - Culinary Lecturer")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("Amy has a passion for food and an interest in the relationship between cooking and food systems. She will be working on the ongoing research around the role of cooking and food agency.")
                                .font(.body)
                            Text("\nSarra Talib - Sustainability Tenets Coordinator")
                                .font(.body)
                                .fontWeight(.bold)
                            Text("A doctoral student in Food Systems with research interests in the best strategies for designing waste out of food systems, with a focus on kitchen work, especially professional kitchens and those who manage them. She will advise the team on current innovations in technology, policy and practice.")
                                .font(.body)
                        }
                        .padding()
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
            .edgesIgnoringSafeArea(.bottom)
        }
}

