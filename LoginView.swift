// Login or create account page
import SwiftUI
import UIKit

// login page
struct LoginView: View {
    let hunterGreen = Color(red: 20/255, green: 71/255, blue: 52/255)
    
    var body: some View {
        VStack {
            Text("Sign in")
                .font(.title)
                .fontWeight(.semibold)

            // sign into account
            HStack {
                Image(systemName: "person.2.circle.fill")
                    .font(.largeTitle)
                    .frame(width: 50)
                    .padding(.trailing, 10)
                
                NavigationLink(destination: SignInEmailView(showSignInView: .constant(true)).navigationBarBackButtonHidden(true)) {
                    Text("Login")
                }
                
                Spacer()
            }
            .padding()
            .background(Color(hunterGreen), in: RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(.white)

            // create account
            HStack {
                Image(systemName: "person.crop.rectangle.badge.plus.fill")
                    .font(.largeTitle)
                    .frame(width: 50)
                    .padding(.trailing, 10)
                
                NavigationLink(destination: SignUpEmailView(showSignInView: .constant(true)).navigationBarBackButtonHidden(true)) {
                    Text("Create Account")
                }
                
                Spacer()
            }
            .padding()
            .background(Color(hunterGreen), in: RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(.white)
        }
        .padding()
    }
}
