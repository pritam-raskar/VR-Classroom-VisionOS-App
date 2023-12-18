//
//  Navbar.swift
//  visionos_frontend
//
//  Created by Abir Pal on 11/10/23.
//

import SwiftUI

struct CourseHeaderStats: View {
    @State private var search: String = ""
    var body: some View {
        VStack {
            HStack(){
                Image(.logo)
                Text("Virtual Class")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    HStack {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        SecureField("Password", text: $search)
                            .frame(height: 6)
                            .padding()
                        
                            .cornerRadius(10.0)
                    }
                }
                
                
            }
            HStack(spacing:15){
                //            Live or not
                HStack {
                    Circle()
                        .fill(.systemRed)
                        .frame(width: 12)
                    Text("Live Now")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .glassBackgroundEffect()
                
                //            No Of Watching
                HStack {
                    Image(systemName: "eye")
                    Text("22k Watching")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .glassBackgroundEffect()
                
                Spacer()
                //            Location
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text("Florida, USA")
                }
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}

#Preview {
    CourseHeaderStats()
}
