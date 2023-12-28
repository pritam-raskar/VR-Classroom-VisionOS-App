//
//  TopCatagorySection.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import SwiftUI

struct CourseListingSection: View {
//    let colums: [GridItem] = [GridItem(.adaptive(minimum: 220, maximum: 330))]
    let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                // section heading 0
                Text("See what you can learn")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20){
                        ForEach(0 ..< 6){ item in
                            CourseCard2(
                                cardThumbnailImage: "university",
                                courseTitle: "Interlocution to Programming with Python and Java",
                                description: "University of Pennsylvania",
                                specilizationDetails: "SPECILIZATION (5 COURSE)"
                            )
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                
                
                // section heading 1
                Text("Learner as viewing")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyVGrid(columns: colums, spacing: 40){
                        ForEach(0 ..< 4){ item in
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
                    }
                }
                .padding(.horizontal, 20)
                
                // section heading 2
                Text("Top catagory")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                
                LazyVGrid(columns: colums, spacing: 20){
                    ForEach(catagory){ item in
                        SectionalCard(cardImage: item.image, title: item.title)
                    }
                }.padding(10)
            }
        }
    }
}

#Preview {
    CourseListingSection()
}
