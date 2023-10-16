//
//  LearnMoreSection.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import SwiftUI

struct LearnMoreSection: View {
    var body: some View {
        VStack {
            Text("See what you can learn")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        CourseCard2()
                        
                }
                .frame(maxWidth: .infinity)
            }.padding(.horizontal, 10)
        }
    }
}

#Preview {
    LearnMoreSection()
}
