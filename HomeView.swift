import SwiftUI
import UIKit


struct ContentView: View {
    var body: some View {
        NavigationStack {
            WelcomeToOurAppView()
        }
    }
}

// Catie: Home page
struct HomeView: View {
    let currentDate = Date()
    @EnvironmentObject var settings: Settings
    
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
                        HStack(spacing: 15) {
                            NavigationLink(destination: RecipeView(recipeId:1).navigationBarBackButtonHidden(false)) {
                                Text("Carrot Soup")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                                
                            NavigationLink(destination: RecipeView(recipeId:5).navigationBarBackButtonHidden(false)) {
                                Text("Garden Salad")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        
                        Text("Popular")
                            .font(.system(size: 30, weight: .bold))
                        
                        HStack(spacing: 15) {
                            NavigationLink(destination: RecipeView(recipeId:15).navigationBarBackButtonHidden(false)) {
                                Text("Pizza")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: RecipeView(recipeId:9).navigationBarBackButtonHidden(false)) {
                                Text("Hummus")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            }
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
                // BTUs and Local Food percentage
                HStack() {
                    // BTU gauge
                    ZStack {
                        // Background Circle
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(0.3)
                            .foregroundColor(.gray)
                        
                        // Progress Arc
                        Circle()
                            .trim(from: 0.0, to: CGFloat(settings.btuUsed))
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [.green, .yellow, .red]),
                                    center: .center
                                ),
                                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut(duration: 0.5), value: settings.btuUsed)
                        
                        // Label
                        Text("\(Int(settings.btuUsed)) BTUs")
                            .bold()
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    
                    // Local Percentage gauge
                    ZStack {
                        // Background Circle
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(0.3)
                            .foregroundColor(.gray)
                        
                        // Progress Arc
                        Circle()
                            .trim(from: 0.0, to: CGFloat(settings.localPercent))
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [.green, .yellow, .red]),
                                    center: .center
                                ),
                                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut(duration: 0.5), value: settings.localPercent)
                        
                        // Label
                        Text("\(Int(settings.localPercent))% local")
                            .bold()
                    }
                    .frame(width: 100, height: 100)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Little info section
                VStack {
                    
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
                    .padding(.bottom, 10)
                    
                    // Button to local options
                    NavigationLink(destination: LocallySourcedOptionsView().navigationBarBackButtonHidden(true)) {
                        Text("Local Options")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 10)
                }
                
                BottomNavigationBar()
            }
            //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


// Catie: Bottom menu bar
struct BottomNavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            // Home
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true).environmentObject(Settings())) {
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
            NavigationLink(destination: ProfileView(
                                name: "",
                                selectedCity: "",
                                selectedAllergies: [],
                                isSignedIn: false
                            )
                            .navigationBarBackButtonHidden(true)) {
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


#Preview {
    ContentView().environmentObject(Settings())
}
