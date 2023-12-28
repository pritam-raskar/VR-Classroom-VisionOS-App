//
//  SplitView.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 27/10/23.
//

import SwiftUI

struct UserSettingView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    //    @FocusState public var emailFieldIsFocused: Bool = false
    var body: some View {
        
        NavigationSplitView {
            List {
                VStack(spacing:30){
                    SettingsNavigationOption(imageName: "user", labelText: "Account")
                    SettingsNavigationOption(imageName:"subscription", labelText: "Subscription")
                    SettingsNavigationOption(imageName: "notification", labelText: "Notifications")
                    SettingsNavigationOption(imageName: "privacy", labelText: "Privacy")
                    SettingsNavigationOption(imageName: "about", labelText: "About")
                }.foregroundColor(.white)
                
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    VStack (alignment: .leading) {
                        Text("Settings")
                            .font(.largeTitle)
                    }
                }
            }
            .navigationSplitViewColumnWidth(230)
        } detail: {
            ScrollView(){
                ZStack(){
                    
                    VStack(alignment: .leading){
                        
                        UserSettingProfilePicture()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,20)
                        
                        
                        VStack {
                            Text("User Name")
                                .frame(maxWidth: .infinity,alignment:.leading)
                            TextField(
                                "Your name",
                                text: $username
                            )
                            .frame(maxWidth: .infinity,maxHeight:10,alignment:.leading)
                            .textInputAutocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(15)
                            .textFieldStyle(PlainTextFieldStyle())
                            
                        }
                        .frame(alignment: .leading)
                        .padding(.bottom,20)
                        VStack {
                            Text("Email")
                                .frame(maxWidth: .infinity,alignment:.leading)
                            TextField(
                                "Your email",
                                text: $email
                            )
                            .frame(maxWidth: .infinity,maxHeight:10,alignment:.leading)
                            .textInputAutocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(15)
                            .textFieldStyle(PlainTextFieldStyle())
                        }
                        .frame(alignment: .leading)
                        .padding(.bottom,20)
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Update")
                        })
                        
                        .padding(.bottom,20)
                        Divider()
                            .frame(height: 1)
                            .overlay(Color.white.opacity(0.3))
                        Text("Password").font(.title)
                        Text("you can change your password by clicking button below").font(.subheadline)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Change Password > ")
                        })
                        .padding(.top,18)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            VStack (alignment: .leading) {
                                Text("Account")
                                    .font(.largeTitle)
                            }
                        }
                    }
                    .padding(.horizontal,40)
                    
                    
                }
            }
        }
        
    }
}

#Preview {
    UserSettingView()
}
