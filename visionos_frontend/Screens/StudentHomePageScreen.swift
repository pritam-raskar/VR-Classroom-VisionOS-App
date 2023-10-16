//
//  StudentHomePageScreen.swift
//  visionos_frontend
//
//  Created by Abir Pal on 12/10/23.
//

import SwiftUI

struct StudentHomePageScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack() {
                ZStack {
                    Image(.thumbnail)
                        .resizable()
                    
                    VStack{
                        CourseHeaderStats()
                        Spacer()
                        CourseTitle()
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20){
                                    CourseCard()
                                    CourseCard()
                                    CourseCard()
                                    CourseCard()
                                    
                                    
                            }.frame(maxWidth: .infinity)
                        }.padding(.horizontal, 4)
                    }
                    .frame(width: .infinity,height: 1025)
//                    .background(.red)
                    .padding(.vertical, 32)
//                    .padding(.horizontal, 10)
                }.background(.univcolor)
                LearnMoreSection()
                    .padding(.bottom, 40)
                TopCatagorySection()
                    .padding(.bottom, 40)
            }
        }
        .tabItem {
            Label("Browser", systemImage: "command")
        }.tag(0)
    }
}

#Preview {
    StudentHomePageScreen()
}


