//
//  CourseCard.swift
//  visionos_frontend
//
//  Created by Abir Pal on 11/10/23.
//

import SwiftUI

// https://api.npoint.io/9d3f810992ced9049b44

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
                            HStack(spacing: 8){
                                Circle()
                                    .fill(.systemRed)
                                    .frame(width: 8)
                                Text("Live Now")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    
                            }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .glassBackgroundEffect()
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack(spacing:8){
                            HStack {
                                Text("UI/UX Design With Figma")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            HStack {
                                Text("5+ Real World Project")
                                    .font(.system(size: 24))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Spacer()
                            }
                            HStack(spacing:4) {
                                Image(systemName: "eye")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24)
                                Text("100k Watching")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Spacer()
                            }
                        }

                    }
                    .padding(.horizontal, 24)
//                    .padding(.vertical, 50)
                    .padding(.top, 20)
                    .padding(.bottom, 28)
                }
            }
            .frame(maxWidth: 562, maxHeight: 316)
            .cornerRadius(24)
    }
}

#Preview {
    CourseCard()
}
