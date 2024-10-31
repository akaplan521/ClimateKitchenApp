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
                        HStack(spacing: 15) {
                            NavigationLink(destination: RecipeView().navigationBarBackButtonHidden(false)) {
                                Text("Winter Squash Risotto")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                                
                            NavigationLink(destination: RecipeView().navigationBarBackButtonHidden(false)) {
                                Text("Viniagrette")
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
                            NavigationLink(destination: RecipeView().navigationBarBackButtonHidden(false)) {
                                Text("Garden Salad")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: 150, maxHeight: 100, alignment: .center)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: RecipeView().navigationBarBackButtonHidden(false)) {
                                Text("Roasted Root Vegetables")
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
