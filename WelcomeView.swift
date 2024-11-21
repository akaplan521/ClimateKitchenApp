// Welcome screen

import SwiftUI
import UIKit

// Logo page
struct WelcomeView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "uvmLogo")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text("Climate Kitchen App")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
        }
        
        .padding()
        
    }
}

// merge the two welcome screens together
struct WelcomeToOurAppView: View {
    let gradientColors: [Color] = [
        .gradientTop,
        .gradientBottom
    ]
    var body: some View {
        TabView {
            WelcomeView()
            LoginView()
        }
        .background(Gradient(colors: gradientColors))
                .tabViewStyle(.page)
    }
}

#Preview {
    WelcomeToOurAppView()
}
