import SwiftUI
import UIKit

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
