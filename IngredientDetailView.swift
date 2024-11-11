import SwiftUI
import UIKit

// Alexa: Individual ingredient page
struct IngredientDetailView: View {
    var ingredient: Ingredient

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(ingredient.name)
                .font(.title)
                .padding()

            Text(ingredient.info)
                .padding()

            //display nutrients
            Text("Nutritional Information")
                .font(.headline)
                .padding(.top)

            ForEach(ingredient.nutrients) { nutrient in
                HStack {
                    Text(nutrient.name)
                        .font(.subheadline)
                    Spacer()
                    Text("\(nutrient.amount, specifier: "%.2f") \(nutrient.unit)")
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Ingredient Details")
    }
}

