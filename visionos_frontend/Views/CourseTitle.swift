//
//  CourseTitle.swift
//  visionos_frontend
//
//  Created by Abir Pal on 11/10/23.
//

import SwiftUI

struct CourseTitle: View {
    var body: some View {
        VStack {
            Text("Danial Walter Scott")
            
            
            Text("Figma UI UX Design Essentials")
                .font(.extraLargeTitle)
                .fontWeight(.bold)
                .frame(width: 500)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.bottom, 20)
            Button(action: {
                print("Hi")
            }, label: {
                Text("Watch Now!")
                    .padding(.horizontal, 5)
            }).tint(.white)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    CourseTitle()
}
