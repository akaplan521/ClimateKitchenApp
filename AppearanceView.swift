//
//  Appearance.swift
//  recipe
//
//  Created by user268927 on 10/31/24.
//

import SwiftUI
import UIKit

// This view will allow user to choose food appearance desciptors, and add to settings
struct AppearanceView: View {
    @EnvironmentObject var settings: Settings
    @State private var foodApperance = [
        (1, "Appetizing"),(2, "Attractive"),(3, "Bright"),(4, "Browned"),
        (5, "Bubbly"),(6, "Burnt"),(7, "Chunky"),(8, "Clear"),(9, "Cloudy"),(10, "Coarse"),
        (11, "Colorful"),(12, "Colorless"),(13, "Crisp"),(14, "Crumbly"),(15, "Delicate"),
        (16, "Dry"),(17, "Dull"),(18, "Fancy"),(19, "Firm"),(20, "Flaky"),(21, "Flat"),
        (22, "Fluffy"),(23, "Foamy"),(24, "Fragile"),(25, "Glossy"),(26, "Golden"),
        (27, "Greasy"),(28, "Grainy"),(29, "Hard"),(30, "Heavy"),(31, "Limp"),
        (32, "Lumpy"),(33, "Moist"),(34, "Mottled"),(35, "Mushy"),(36, "Opaque"),
        (37, "Pale"),(38, "Uniform"),(39, "Varied")]
    
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false]
    
    // function used to set appearance
    func setAppearance(a: Int) {
        if !settings.appearance.contains(foodApperance[a].1){
            settings.appearance.append(foodApperance[a].1)
        }
        
    }
    // function used to remove appearance
    func removeAppearance(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.appearance.firstIndex(where: {$0 == foodApperance[a].1}){
            settings.appearance.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Food appearance plays a crucial role in the overall dining experience, influencing our perceptions of taste, quality, and appeal.").lineSpacing(10)
         
        ForEach(0..<foodApperance.count, id: \.self) { index in
            HStack {
                if (index % 3 ) == 0{
                    // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: space the text out better
                        Text(foodApperance[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodApperance[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodApperance[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set appearance string
                            setAppearance(a: index)
                        }
                        if newValue == false{
                            // call function to delete appearance string
                            removeAppearance(a: index)
                        }
                    }
                }
            

                    
           }
               
        }
        
        
    }
    
}

