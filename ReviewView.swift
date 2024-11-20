import SwiftUI

struct ReviewView: View {
    @State private var comments: String = ""
    @State private var fillColor = [Color.black, Color.black, Color.black, Color.black, Color.black]
    @State private var selectedAroma: Set<Int> = []
    @State private var selectedFlavor: Set<Int> = []
    @State private var selectedTexture: Set<Int> = []
    @State private var showRecipeHomeView = false

    let aroma = [
        (1, "Acidic"), (2, "Bitter"), (3, "Briny"), (4, "Burnt"), (5, "Citrusy"), (6, "Floral"), (7, "Mild"), (8, "Sharp"), (9, "Smoky"), (10, "Yeasty")
    ]
    
    let flavor = [
        (1, "Acidic"), (2, "Bland"), (3, "Bitter"), (4, "Bright"),
        (5, "Fresh"), (6, "Mild"), (7, "Nutty"), (8, "Rich"), (9, "Peppery"), (10, "Salty"), (11, "Smoky"), (12, "Spicy"), (13, "Tangy"), (14, "Yeasty"), (15, "Zesty")
    ]
    
    let texture = [
        (1, "Bouncy"), (2, "Brittle"), (3, "Chewy"), (4, "Chunky"),
        (5, "Crispy"), (6, "Dry"), (7, "Flaky"), (8, "Fluffy"), (9, "Gresay"), (10, "Grainy"), (11, "Juicy"), (12, "Moist"), (13, "Rubbery"), (14, "Tender"), (15, "Tough")
    ]

    var body: some View {
        VStack (alignment: .leading){
//            // info from user to calculate BTUs
//            Text("Energy Info")
//                    .font(.title)
//                    .padding()
//                
//            
            // review
            Text("Leave Some Feedback")
                .font(.title)
                .padding()
            Text("Rating")
                .font(.headline)
                .padding(10)
            // Rating Stars
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .foregroundColor(fillColor[index])
                        .onTapGesture {
                            updateStars(for: index)
                        }
                }
            }
            .padding(10)

            // Categories with horizontal scroll and multiple selection
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    categoryView(title: "Aromas", options: aroma, selectedOptions: $selectedAroma)
                    categoryView(title: "Flavors", options: flavor, selectedOptions: $selectedFlavor)
                    categoryView(title: "Textures", options: texture, selectedOptions: $selectedTexture)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Additional Comments:").font(.headline)
                    .padding()
                TextEditor(text: $comments)
                                    .frame(height: 100)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1))
                                            .padding()
            }
            
            // TODO: have submit button run BTU and % local calculations
            // Submit Button
            Button(action: {
                showRecipeHomeView = true
                print("Selected Aroma: \(selectedAroma)")
                print("Selected Flavor: \(selectedFlavor)")
                print("Selected Texture: \(selectedTexture)")
            })
            {
                Text("Submit Review")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.navigationDestination(isPresented: $showRecipeHomeView) {
                RecipeHomeView().environmentObject(Settings()).navigationBarBackButtonHidden(true)
            }
            .padding()
        }.navigationTitle("Feedback")
    }

    // Helper function to update stars
    func updateStars(for index: Int) {
        for i in 0...index {
            fillColor[i] = .yellow
        }
        for i in (index + 1)..<5 {
            fillColor[i] = .black
        }
    }

    // function to create category views/scrolls
    func categoryView(title: String, options: [(Int, String)], selectedOptions: Binding<Set<Int>>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(options, id: \.0) { option in
                        Text(option.1)
                            .padding()
                            .background(selectedOptions.wrappedValue.contains(option.0) ? Color.blue : Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                if selectedOptions.wrappedValue.contains(option.0) {
                                    selectedOptions.wrappedValue.remove(option.0)
                                } else {
                                    selectedOptions.wrappedValue.insert(option.0)
                                }
                            }
                    }
                }
            }
        }
    }
}
