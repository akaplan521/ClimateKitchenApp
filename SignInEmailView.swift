//
//  SignInEmailView.swift
//  CC-All
//
//  Created by Wyatt Chrisman on 11/6/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    // sign up error
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInError.missingCredentials
        }
        
        let returnedUserData = try await AuthenticationManager.shared.createUser(
            email: email,
            password: password
        )
        print("Success Sign Up")
        print(returnedUserData)
    }
    
    // sign in error
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInError.missingCredentials
        }
        
        let returnedUserData = try await AuthenticationManager.shared.signInUser(
            email: email,
            password: password
        )
        print("Success Sign In")
        print(returnedUserData)
        
    }
    
    // info missing error
    enum SignInError: LocalizedError {
        case missingCredentials
        var errorDescription: String? {
            switch self {
            case .missingCredentials:
                return "Email or password is missing."
            }
        }
    }
    
}

// sign in view
struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var navigateToHome = false
    @State private var errorMessage: String?
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email...", text: $viewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password...", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Button {
                    Task {
                        do {
                            try await viewModel.signIn()
                            navigateToHome = true
                        } catch {
                            errorMessage = error.localizedDescription
                            return
                        }
                        
                    }
                    
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In With Email")
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView().environmentObject(Settings()).navigationBarBackButtonHidden(true)
            }
        }
    }
}

// sign up view
struct SignUpEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var navigateToHome = false
    @State private var errorMessage: String?
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email...", text: $viewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password...", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            navigateToHome = true
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                        
                    }
                    
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign Up With Email")
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView().environmentObject(Settings()).navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
