//
//  Texture.swift
//  recipe
//
//  Created by user268927 on 10/31/24.
//

import SwiftUI
import UIKit

// This view will allow user to choose food texture desciptors, and add to settings
struct TextureView: View {
    @EnvironmentObject var settings: Settings
    @State private var foodTexture = [
            (1, "Bouncy"),(2, "Brittle"),(3, "Bubbly"),(4, "Chewy"),
            (5, "Chunky"),(6, "Coarse"),(7, "Crispy"),(8, "Crumbly"),
            (9, "Crunchy"),(10, "Crusty"),(11, "Dry"),(12, "Elastic"),
            (13, "Fibrous"),(14, "Firm"),(15, "Fizzy"),(16, "Flaky"),
            (17, "Fleshy"),(18, "Fluffy"),(19, "Foamy"),(20, "Gooey"),
            (21, "Greasy"),(22, "Grainy"),(23, "Gritty"),(24, "Juicy"),
            (25, "Lumpy"),(26, "Mealy"),(27, "Moist"),(28, "Mushy"),
            (29, "Pulpy"),(30, "Powdery"),(31, "Rubbery"),(32, "Runny"),
            (33, "Sandy"),(34, "Silky"),(35, "Slimy"),(36, "Smooth"),
            (37, "Soft"),(38, "Soggy"),(39, "Soupy"),(40, "Spongy"),
            (41, "Springy"),(42, "Starchy"),(43, "Sticky"),(44, "Stiff"),
            (45, "Tender"),(46, "Tough"),(47, "Velvety"),(48, "Waxy")]
   
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
                                    false,  false,false,false,
                                    false,  false, false]
    
    // function used to set texture
    func setTexture(a: Int) {
        if !settings.texture.contains(foodTexture[a].1){
            settings.texture.append(foodTexture[a].1)
        }
        
    }
    // function used to remove texture
    func removeTexture(a: Int) {
       // if the string is in appearance list, find index and remove
        if let index = settings.texture.firstIndex(where: {$0 == foodTexture[a].1}){
            settings.texture.remove(at: index)
        }

    }
    
    var body: some View {
        Text("Texture is not about tase, it's the mouth feel we percieve when we are eating. Texture is a vital component that can make or break our satisfaction with a dish").lineSpacing(10)
         
        ForEach(0..<foodTexture.count, id: \.self) { index in
            HStack {
            // Toggle check box
                if(index % 3) == 0 {
                    Toggle(isOn: $isChecked[index]) {
                        // TODO: spacing the text out better
                        Text(foodTexture[index].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+1]) {
                        Text(foodTexture[index+1].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+1], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    Toggle(isOn: $isChecked[index+2]) {
                        Text(foodTexture[index+2].1)
                    }.toggleStyle(CheckboxToggleStyle())
                    .onChange(of: isChecked[index+2], initial: true) { oldValue, newValue in
                        if newValue == true {
                            // call function to set texture string
                            setTexture(a: index)
                        }
                        if newValue == false{
                            // call function to delete texture string
                            removeTexture(a: index)
                        }
                    }
                    
                }
                    

           }
               
        }
        
        
    }
    
}

