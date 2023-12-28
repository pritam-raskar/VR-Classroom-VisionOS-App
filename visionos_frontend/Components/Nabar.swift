//
//  Nabar.swift
//  visionos_frontend
//
//  Created by Abir Pal on 27/12/23.
//

import SwiftUI

struct Nabar: View {
    @State private var search: String = ""
    @State var isInstructor : Bool
    @State var userName : String
    
    
    var body: some View {
        HStack(){
            Image(.logo)
            Text("Virtual Class")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            HStack {
                HStack {
                    TextField("Search..", text: $search)
                        .frame(height: 6)
                        .padding()
                    
                        .cornerRadius(10.0)
                }
            }
            Text(isInstructor ? "Instructor" : "Student")
            Image(systemName: "bell.badge.fill")
            
            HStack(spacing: 3) {
                // USER INITIAL
                Text("PR")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(Color(.systemGray))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding()
                
                // User name
                Text("Hello \(userName)")
                
                // DropDown
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 13, height: 7)
            }
            
        }
    }
}

#Preview {
    Nabar(isInstructor: true, userName: "Pritam")
}
