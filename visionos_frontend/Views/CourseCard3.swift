//
//  CourseCard3.swift
//  visionos_frontend
//
//  Created by Abir Pal on 16/10/23.
//

import SwiftUI

struct CourseCard3: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Image(.courseThumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
            Text("The Complete 2023 Web Development Bootcamp")
                .font(.title2)
            
            Text("Dr. Angel Yu")
                .font(.footnote)
            
            HStack{
                Text("4.7")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack(spacing: 4) {
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.yellow)
                    }
                }
                
                Text("(325,567)")
                    .font(.caption2)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    
            }
            HStack {
                Text("$11")
                    .font(.title3)
                
                Text("$28")
                    .font(.subheadline)
                    .strikethrough()
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            
            Label("Bestseller", systemImage: "trophy.fill")
                .padding(.horizontal, 17).padding(.vertical, 5)
                .background(.blue)
                .font(.caption).fontWeight(.bold)
                .cornerRadius(100)
                
            
            
            
            
        }
            .frame(width: 323, height: 419)
//            .background(.red)
    }
}

#Preview {
    CourseCard3()
}
