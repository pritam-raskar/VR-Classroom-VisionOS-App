//
//  CourseCard3.swift
//  visionos_frontend
//
//  Created by Abir Pal on 16/10/23.
//

import SwiftUI

struct CourseCard3: View {
    @State var courceThumbnail : String
    @State var courseTitle : String
    @State var authorName : String
    @State var ratings : Float
    @State var noOfReview : Int
    @State var discountedPrice : Float
    @State var actualPrice : Float
    @State var bestSellerOrNot = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            //course thumbnail
            Image(courceThumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
            
            // title of the course
            Text(courseTitle)
                .font(.title2)
            
            // author name
            Text(authorName)
                .font(.footnote)
            
            // rating and review
            HStack{
                //ratings
                Text("\(ratings, specifier: "%.1f")")
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // ratings stars
                HStack(spacing: 4) {
                    ForEach(0 ..< Int(ratings), id: \.self) { item in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.yellow)
                    }
                }
                
                // no of review
                Text("(\(noOfReview))")
                    .font(.caption2)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                
            }
            
            // Price segment
            HStack {
                // discounted price
                Text("$\(discountedPrice, specifier: "%.2f")")
                    .font(.title3)
                
                // actual price
                Text("$\(actualPrice, specifier: "%.2f")")
                    .font(.subheadline)
                    .strikethrough()
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            
            // make bestseller tag visible or not
            if bestSellerOrNot {
                Label("Bestseller", systemImage: "trophy.fill")
                    .padding(.horizontal, 17).padding(.vertical, 5)
                    .background(.blue)
                    .font(.caption).fontWeight(.bold)
                    .cornerRadius(100)
            }else {}
        }
        .frame(maxWidth : 300, maxHeight: 400)
    }
}

#Preview {
    CourseCard3(
        courceThumbnail: "courseThumbnail",
        courseTitle: "The Complete 2023 Web Development Bootcamp",
        authorName: "Dr Angel Yu",
        ratings: 4.3,
        noOfReview: 325567,
        discountedPrice: 11,
        actualPrice: 28
    )
}
