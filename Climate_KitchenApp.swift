//
//  Climate_KitchenApp.swift
//  Climate Kitchen
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct Climate_KitchenApp: App {
    @State private var ShowSignInView: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
    
    init () {
        // use firebase library
        FirebaseApp.configure()
    }
}
