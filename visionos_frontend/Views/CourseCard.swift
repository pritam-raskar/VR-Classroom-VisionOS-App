//
//  CourseCard.swift
//  visionos_frontend
//
//  Created by Abir Pal on 11/10/23.
//

import SwiftUI

struct CourseCard: View {
    var body: some View {
            VStack {
                ZStack {
                    Image(.courseCardThumbnail)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    
                    VStack{
//                        Live Button Bar
                        HStack {
                            HStack(spacing: 4){
                                Circle()
                                    .fill(.systemRed)
                                    .frame(width: 5)
                                Text("Live Now")
                                    .font(.system(size: 7))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    
                            }
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .glassBackgroundEffect()
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack(spacing:3){
                            HStack {
                                Text("UI/UX Design With Figma")
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            HStack {
                                Text("5+ Real World Project")
                                    .font(.system(size: 15))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Spacer()
                            }
                            HStack(spacing:4) {
                                Image(systemName: "eye")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                Text("100k Watching")
                                    .font(.system(size: 8))
                                Spacer()
                            }
                        }

                    }
                    .padding(10)
                    .padding(.vertical, 13)
                }
            }
            .frame(width: 290, height: 160)
            .cornerRadius(15)
    }
}

#Preview {
    CourseCard()
}
