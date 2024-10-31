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
