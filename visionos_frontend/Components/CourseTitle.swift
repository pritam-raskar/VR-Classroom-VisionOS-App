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
                .font(.system(size : 18))
                .fontWeight(.medium)
            
            Text("Figma UI UX Design Essentials")
                .font(.system(size : 88))
                .fontWeight(.bold)
                .frame(width: 800)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.bottom, 20)
            Button(action: {
                print("Hi")
            }, label: {
                Text("Watch Now!")
                    .font(.system(size : 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 5)
            }).tint(.white)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    CourseTitle()
}
