//
//  Armoa.swift
//  recipe
//
//  Created by user268927 on 10/31/24.
//
import SwiftUI
import UIKit

// This view will allow user to choose food aroma desciptors, and add to settings
struct Armoa: View {
    @EnvironmentObject var settings: Settings
    @State private var foodAroma = [
            (1, "Acidic"),(2, "Acrid"),(3, "Bitter"),(4, "Bland"),
            (5, "Briny"),(6, "Burnt"),(7, "Citrus"),(8, "Earthy"),
            (9, "Floral"),(10, "Fruity"),(11, "Green"),(12, "Herbaceous"),
            (13, "Lemony"),(14, "Mild"),(15, "Minty"),(16, "Musty"),
            (17, "Perfumed"),(18, "Piney"),(19, "Piquant"),(20, "Pungent"),
            (21, "Rancid"),(22, "Rotten"),(23, "Savory"),(24, "Sharp"),
            (25, "Smoky"),(26, "Sulfurous"),(27, "Sweet"),(28, "Tart"),
            (29, "Weak"),(30, "Woody"),(31, "Yeasty"),(32, "Zesty"),(33, "Zingy")
    ]
    @State private var isChecked = [false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false, false,
                                    false, false, false]
    
    // function used to set aroma
    func setAroma(a: Int) {
        if !settings.aroma.contains(foodAroma[a].1){
            settings.aroma.append(foodAroma[a].1)
        }
        
    }
    // function used to remove aroma
    func removeAroma(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.aroma.firstIndex(where: {$0 == foodAroma[a].1}){
            settings.aroma.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Aroma is a vital component to our culinary experience, accounting for approximately 80% of what we perceive as flavor").lineSpacing(10)
         
        ForEach(0..<foodAroma.count, id: \.self) { index in
            HStack {
                if (index % 3) == 0{
                    // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                        Text(foodAroma[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodAroma[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodAroma[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set aroma string
                            setAroma(a: index)
                        }
                        if newValue == false{
                            // call function to delete aroma string
                            removeAroma(a: index)
                        }
                    }
                }
            

                    
           }
            BottomNavigationBar()
        }
        
        
    }
    
}

