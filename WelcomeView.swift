// Welcome screen

import SwiftUI
import UIKit

// Logo page
struct WelcomeView: View {
    @State private var showImage = false
    @State private var showText = false
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "uvmLogo")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .offset(y: showImage ? 0 : -400)
                .animation(.easeOut(duration: 0.8), value: showImage)
            
            Text("Climate Kitchen App")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                .offset(y: showText ? 0 : 400)
                .animation(.easeOut(duration: 0.8).delay(0.2), value: showText)
            
        }
        
        .padding()
        .onAppear {
            // trigger animations
            showImage = true
            showText = true
        }
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
