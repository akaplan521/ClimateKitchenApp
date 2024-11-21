// Login or create account page
import SwiftUI
import UIKit

// formatting
struct LoginCards: View {
    let iconName: String
    let description: String
    let hunterGreen = Color(red: 20/255, green: 71/255, blue: 52/255)
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.largeTitle)
                .frame(width: 50)
                .padding(.trailing, 10)
            
            // TODO: change navLink to two separate sign in pages?
            NavigationLink(destination: SignInEmailView(showSignInView: .constant(false)).navigationBarBackButtonHidden(true)) {
                Text(description)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(hunterGreen), in: RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }
}

// login page
struct LoginView: View {
    var body: some View {
        VStack {
            Text("Sign in")
                .font(.title)
                .fontWeight(.semibold)
            
            LoginCards(iconName: "person.2.circle.fill",
                        description: "Login")
            
            LoginCards(iconName: "person.crop.rectangle.badge.plus.fill",
                        description: "Create Account")
        }
        .padding()
    }
}


#Preview {
    LoginView()
}
