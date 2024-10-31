//
//  ApplianceView.swift
//  recipe
//
//  Created by user268927 on 10/31/24.
//

import SwiftUI
import UIKit

// This view will allow user to choose from appliance type, sets type to settings
struct ApplianceView: View {
    @EnvironmentObject var settings: Settings
    @State private var applianceTypes=["Gas",
                                    "Electric",
                                    "Induction"]
    @State private var isChecked = [false,false,false]
    
    // function used to set appliance
    func setAppliance(newAppliance: Int) {
        settings.applianceType = applianceTypes[newAppliance]
    }
    var body: some View {
        Text("By choosing a appliance, the energy usage will be enabled using universal metrics. This will be represented in your profile if you choose I MADE THIS , recipe").lineSpacing(10)
            // allow user to choose appliance type
        ForEach(applianceTypes.indices, id: \.self) { index in
            HStack {
            // Toggle check box
                    Toggle(isOn: $isChecked[index]) {
                    Text(applianceTypes[index])
                    }.toggleStyle(CheckboxToggleStyle())
                    // This allows user to only click one
                    .onChange(of: isChecked[index], initial: true) { oldValue, newValue in
                        if newValue {
                            // call function to set appliance type
                            setAppliance(newAppliance: index)
                            // Uncheck others if one is checked
                            for i in isChecked.indices {
                                if i != index {
                                    isChecked[i] = false
                                }
                            }
                        }
                    }
           }
               
        }
        
        
    }
    
}

