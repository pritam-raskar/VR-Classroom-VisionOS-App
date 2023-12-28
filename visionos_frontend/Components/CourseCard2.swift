//
//  CourseCard2.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import SwiftUI

struct CourseCard2: View {
    @State var cardThumbnailImage: String
    @State var courseTitle: String
    @State var description : String
    @State var specilizationDetails : String
    
    
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Image(cardThumbnailImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 160)
            }
            .frame(width: 331)
            .background(.univcolor)
                
                

                
            VStack(alignment: .leading, spacing: 10) {
                Text(courseTitle)
                    .font(.system(size: 24))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(description)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                
                Spacer()
                
                Text(specilizationDetails)
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                    .padding(.bottom, 10)
            }
            .padding(20)
        }
        .frame(width: 331, height: 440)
        .glassBackgroundEffect()
            
    }
}

#Preview {
    CourseCard2(
        cardThumbnailImage: "university",
        courseTitle: "Interlocution to Programming with Python and Java",
        description: "University of Pennsylvania",
        specilizationDetails: "SPECILIZATION (5 COURSE)"
    )
}
