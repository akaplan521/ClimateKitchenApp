// Abi: Recipe page
// Abi: how to make a check box https://www.appcoda.com/swiftui-checkbox/
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}

struct RecipeView: View {
    
    @State private var value = 0
    @State private var sesonal = [true, true,true, false, false]
    @State private var isChecked = [false,false,false,false, false]
    @State  var useRed = false

    static var MAXVAL = 5
    
    //TODO: These will get read in from database, is checked will be all set to false with length of ingredients
    let ingredients = [("1","Carrot"), ("2-3","Beets"),("1", "Parsnip"),("3-4 T","Olive Oil" ), ("Dash", "Salt")]
    let recipeTitle = "Roasted Root Vegetables"
    let instructions = [("1.", "Preheat the oven to 425°F."),("2.","Wash, peel and cut veggies."),("3.", "On a low-sided baking sheet, toss veggies together with salt and olive oil. Spread them out and roast until browned and tender, 25-30 minutes.")]
    
    var body: some View {
        NavigationStack {
        VStack() {
            Text(recipeTitle).font(.largeTitle)
            VStack{
                // TODO: Enter Image
                HStack(){
                    // Show ingredients and instructions in list view
                    List {
                        ForEach(ingredients.indices, id: \.self) { index in
                            HStack {
                                // Toggle check box and if ingredient is seasonal or not
                                Toggle(isOn: $isChecked[index]) {
                                    if sesonal[index] == true{
                                        Text(self.ingredients[index].0)
                                        NavigationLink(destination: NutrientView()) {
                                            Text(ingredients[index].1).foregroundColor(.green)
                                                        }
                                    }
                                    else{
                                        Text(self.ingredients[index].0)
                                        NavigationLink(destination: NutrientView()) {
                                            Text(ingredients[index].1).foregroundColor(.red)
                                        }
                                    }
                                    
                                }.toggleStyle(CheckboxToggleStyle())
                            }
                        }
                        
                        ForEach(instructions.indices, id: \.self) { index in
                            // if instrucstions contain over, but can be other appliances
                            // allow user to choose appliance type
                            HStack {
                                if instructions[index].1.contains("oven"){
                                    Text(self.instructions[index].0)
                                    Text(self.instructions[index].1)
                                    NavigationLink(destination: ApplianceView()) {
                                                        Text("Appliance Type")
                                                    }
                                                    
                                }
                                else {
                                    Text(self.instructions[index].0)
                                    Text(self.instructions[index].1)
                                }
                                
                            }
                        }
                        
                        HStack(spacing:100){
                            // Add all the stats to profile
                            Button("I MADE THIS"){
                                
                            }
                            // Add to Database like or dislike
                            Button("Like"){
                                
                            }
                            Button("Dislike"){
                                
                            }
                        }
                    }                    
                }
            }
            //BottomNavigationBar()
            }           
        }
    }  
}
