import SwiftUI
import UIKit

// Alexa: Individual ingredient page


struct IngredientDetailView: View {
    var ingredient: Ingredient

    //ids in the dataset for the nutrients we want to display; can be changed if we want to add more (jk this doesnt do anything its in search view)
    let allowedNutrientIDs: Set<Int> = [1003, 1004, 1005, 2000, 1235, 1093, 1051]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(ingredient.name)
                .font(.title)
                .padding()

            Text(ingredient.info)
                .padding()

            //display nutrients idk how we want to format this
            Text("Nutritional Information (Per 100g)")
                .font(.headline)
                .padding(.top)

            ForEach(ingredient.nutrients) { nutrient in
                            HStack {
                                Text(nutrient.nutrientName)
                                    .font(.subheadline)
                                Spacer()
                                Text("\(nutrient.value, specifier: "%.2f") \(nutrient.unitName)")
                                    .font(.subheadline)
                            }
                            .padding(.horizontal)
                        }

                        Spacer()
                    }
                    .navigationTitle("Ingredient Details")
                }
            }

