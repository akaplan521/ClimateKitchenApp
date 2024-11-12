//
//  AuthenticationView.swift
//  CC-All
//
//  Created by Wyatt Chrisman on 10/31/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In / Up With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In / Up")
        
    }
}


#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
