import SwiftUI
import UIKit

// Alexa: Individual ingredient page
struct IngredientDetailView: View {
    let ingredient: Ingredient

    var body: some View {
        VStack {
            Text(ingredient.name)
                .font(.largeTitle)
                .padding()

            Text(ingredient.info)
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("Ingredient Info")
    }
}
