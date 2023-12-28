//import SwiftUI
//struct RegistrationView: View{
//    @State private var name: String = ""
//    
//    @State private var email: String = ""
//    
//    
//    @State private var password: String = ""
//    
//    var body: some View {
//        ZStack {
//            GeometryReader { geometry in
//                VStack(spacing: 20) {
//                    VStack {
//                        VStack {
//                            Text("Sign Up")
//                                .fontWeight(.bold)
//                                .font(.system(size: 23))
//                                .foregroundColor(Color.white)
//                        }
//                        Divider()
//                            .frame(height: 2)
//                            .background(Color.white.opacity(0.1))
//                        Text("Register")
//                            .fontWeight(.bold)
//                            .font(.system(size: 16))
//                            .foregroundColor(Color.white)
//                            .padding(.top)
//                        Text("Welcome to Virtual Classes! New User?Register below for access to powerful tools.")
//                            .font(.system(size: 13))
//                            .padding(5)
//                            .foregroundColor(Color.white)
//                    }
//                    VStack(spacing: 10) {
//                        HStack {
//                            Image(systemName: "person")
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                            
//                            TextField("Username", text: $name)
//                                .frame(height: 6)
//                                .padding()
//                                .autocapitalization(.none)
//                        }
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(10.0)
//                        
//                        HStack {
//                            Image(systemName: "envelope")
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                            
//                            TextField("Email", text: $email)
//                                .frame(height: 6)
//                                .padding()
//                                .autocapitalization(.none)
//                        }
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(10.0)
//                        
//                        HStack {
//                            Image(systemName: "lock")
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                            
//                            SecureField("Password", text: $password)
//                                .frame(height: 6)
//                                .padding()
//                                .cornerRadius(10.0)
//                        }
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(10.0)
//                        
//                        Button(action: {
//                            // Action when signup button is tapped
//                        }) {
//                            Text("Sign Up")
//                                .padding()
//                                .foregroundColor(.white)
//                                .cornerRadius(10.0)
//                        }
//                        .padding(.top)
//                    }
//                }
//                .padding()
//                .background(Color.black.opacity(0.2))
//                .cornerRadius(15.0)
//            }
//            .onTapGesture {
//                if $0.location(in: geometry.frame).x < geometry.size.width * 0.2
//                    || $0.location(in: geometry.frame).x > geometry.size.width * 0.8
//                    || $0.location(in: geometry.frame).y < geometry.size.height * 0.2
//                    || $0.location(in: geometry.frame).y > geometry.size.height * 0.8 {
//                    // Dismiss the registration form when tapped outside the form
//                    withAnimation {
//                        self.showRegistrationForm = false
//                    }
//                }
//            }
//        }
//    }
//}
//}


import SwiftUI

struct LoginView: View {
 @State private var showRegistrationForm = false

 var body: some View {
  VStack {
   Button("Sign Up") {
    self.showRegistrationForm = true
   }

   if showRegistrationForm {
    RegistrationView()
     .onDisappear {
      self.showRegistrationForm = false
     }
   }
  }
 }
}

struct RegistrationView: View {
 @State private var name: String = ""
 @State private var email: String = ""
 @State private var password: String = ""

 var body: some View {
  ZStack {
   VStack(spacing: 20) {
    VStack {
     VStack {
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
    }
    VStack(spacing: 10) {
     HStack {
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

     Button(action: {
      // Action when signup button is tapped
     }) {
      Text("Sign Up")
       .padding()
       .foregroundColor(.white)
       .cornerRadius(10.0)
     }
     .padding(.top)
    }
   }
   .padding()
   .background(Color.black.opacity(0.2))
   .cornerRadius(15.0)
   .padding()
   .frame(width: 400, height: 500, alignment: .center)
  }
 }
}

struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
   LoginView()
 }
}
