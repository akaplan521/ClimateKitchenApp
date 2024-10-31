import SwiftUI
import UIKit

// Abi: Appliances page
struct ApplianceView: View {
    // TODO: This will need to be figured out: type of appliances, only allow one button
    let applianceType = ["Gas", "Electric","Induction"]
    @State private var isChecked = [false,false,false]
    @State private var countChecked = 0
    var body: some View {
        Text("By choosing a appliance, the energy usage will be enabled using universal metrics. This will be represented in your profile if you choose I MADE THIS , recipe").lineSpacing(10)
        ForEach(applianceType.indices, id: \.self) { index in
            // allow user to choose appliance type
            HStack {
                if countChecked == 0{
                    Toggle(isOn: $isChecked[index]) {
                        Text(self.applianceType[index])
                        
                    }.toggleStyle(CheckboxToggleStyle())
                }
                    
            }
        }
        
    }
}
