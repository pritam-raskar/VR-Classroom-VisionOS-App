//
//  LoginView.swift
//  visionos_frontend
//
//  Created by Abir Pal on 28/12/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                VStack(){
                    VStack(){
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .font(.system(size: 23))
                            .foregroundColor(Color.white)
                    }
                    Divider()
                        .frame(height: 2)
                        .background(Color.white.opacity(0.1))
                    Text("Get's Started")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    Text("Welcome to Virtual Classes! New User?Register below for access to powerful tools.")
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(Color.white)
                    
                    
                    SignInWithAppleButton(
                        .continue,
                        onRequest: { request in
                            request.requestedScopes = [.email, .fullName]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let auth):
                                switch auth.credential {
                                case let credential as ASAuthorizationAppleIDCredential:
                                    // Handle successful authentication
                                    let userId = credential.user
                                    
                                    let email = credential.email
                                    let firstName = credential.fullName?.givenName
                                    let lastName = credential.fullName?.familyName
                                    print("\(String(describing: email)) -- \(String(describing: firstName))")
                                    print(credential     .user)
                                    print(credential )
                                default:
                                    // Handle other typ"es of credentials if needed
                                    break
                                }
                            case .failure(let error):
                                // Handle the failure case
                                if let authError = error as? ASAuthorizationError {
                                    print("Apple Sign In failed with error: \(authError.localizedDescription)")
                                    print("Error code: \(authError.code.rawValue)")
                                } else {
                                    print("Apple Sign In failed with an unknown error")
                                }
                            }
                        }
                    )
                    .frame( height: 40)
                    .padding()
                    .cornerRadius(5.0)
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(15.0)
                .padding()
                .frame(width: 400, height: 500, alignment: .center)
            }
        }
    }
}



#Preview {
    LoginView()
}
