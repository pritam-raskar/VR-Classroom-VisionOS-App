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
                        .aspectRatio(contentMode: .fill)
                    
                    VStack{
                        CourseHeaderStats()
                            .padding(.top, 30)
                            .padding(.bottom, 10)
                        CourseTitle()
                        
                        Spacer()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(0..<10) {_ in
                                    CourseCard()
                                }
                            }
                        }
                        .frame(width: .infinity, height: 100)
                        .padding(10)
                        .padding(.bottom, 30)
                        .padding(.top, 100)
                        
                    }
                }
                Text("Hello")
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
