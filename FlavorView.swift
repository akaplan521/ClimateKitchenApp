//
//  Flavor.swift
//  recipe
//
//  Created by user268927 on 10/31/24.
//

import SwiftUI
import UIKit

// This view will allow user to choose food Flavor desciptors, and add to settings
struct FlavorView: View {
    @EnvironmentObject var settings: Settings
    
    @State private var foodFlavor = [
           (1, "Acerbic"),(2, "Acidic"),(3, "Astringent"),(4, "Bland"),
           (5, "Bitter"),(6, "Bright"),(7, "Briny"),(8, "Burnt"),(9, "Buttery"),
           (10, "Citrus"),(11, "Cool"),(12, "Creamy"),(13, "Dry"),(14, "Earthy"),
           (15, "Fatty"),(16, "Fresh"),(17, "Fruity"),(18, "Grassy"),(19, "Heavy"),
           (20, "Light"),(21, "Meaty"),(22, "Mellow"),(23, "Metallic"),(24, "Mild"),
           (25, "Nutty"),(26, "Plain"),(27, "Rancid"),(28, "Rich"),(29, "Peppery"),
           (30, "Saccharine"),(31, "Saline"),(32, "Salty"),(33, "Savory"),(34, "Sharp"),
           (35, "Smoky"),(36, "Sour"),(37, "Spicy"),(38, "Stale"),(39, "Sweet"),(40, "Tangy"),
           (41, "Tart"),(42, "Vegetal"),(43, "Yeasty"),(44, "Zesty")]
    
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false, false, false, false,
                                    false, false, false,false,
                                    false,  false]
    
    // function used to set flavor
    func setFlavor(a: Int) {
        if !settings.flavor.contains(foodFlavor[a].1){
            settings.flavor.append(foodFlavor[a].1)
        }
        
    }
    // function used to remove flavor
    func removeFlavor(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.flavor.firstIndex(where: {$0 == foodFlavor[a].1}){
            settings.flavor.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Food flavor is a multifaceted phenomenon that arises from the intricate combination of taste, smell, and texture.").lineSpacing(10)
         
        ForEach(0..<foodFlavor.count, id: \.self) { index in
            HStack {
            // Toggle check box
                if (index % 2) == 0{
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: spacing the text out better
                        Text(foodFlavor[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set flavor string
                            setFlavor(a: index)
                        }
                        if newValue == false{
                            // call function to delete flavor string
                            removeFlavor(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodFlavor[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set flavor string
                            setFlavor(a: index)
                        }
                        if newValue == false{
                            // call function to delete flavor string
                            removeFlavor(a: index)
                        }
                    }
                }
                    

                    
           }
               
        }
        
        
    }
    
}

#Preview {
    FlavorView().environmentObject(Settings())
        
}
