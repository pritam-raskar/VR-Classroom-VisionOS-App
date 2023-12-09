import SwiftUI

struct SwiftUIView: View {
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
                    Text("Register")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    Text("Welcome to Virtual Classes! New User?Register below for access to powerful tools.")
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(Color.white)
                    VStack(spacing: 10) {
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            TextField("Username", text: $name)
                                .frame(height: 6)
                                .padding()
                            
                                .autocapitalization(.none)
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10.0)
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            TextField("Email", text: $email)
                                .frame(height: 6)
                                .padding()
                                .autocapitalization(.none)
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10.0)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            SecureField("Password", text: $password)
                                .frame(height: 6)
                                .padding()
                            
                                .cornerRadius(10.0)
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10.0)
                        
                    }
                    
                    Button(action: {
                        // Action when signup button is tapped
                    }) {
                        Text("Sign Up")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(10.0)
                    }.padding(.top)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
