//
//  TopCatagorySection.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import SwiftUI

struct TopCatagorySection: View {
    let colums: [GridItem] = [GridItem(.adaptive(minimum: 220, maximum: 330))]
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Learner as viewing")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {
                        ForEach(0 ..< 5){ item in
                            CourseCard3()
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                
                Text("Top catagory")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                
                LazyVGrid(columns: colums, spacing: 20){
                    ForEach(catagory){ cat in
                        VStack(alignment: .leading, spacing: 1) {
                            Button(action: {
                                print("Hi")
                            }) {
                                VStack {
                                    Image(cat.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                        
                                }
                                    .frame(width: 220, height: 220)
                                    .cornerRadius(3)
                                    .hoverEffect()
                                    .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 20)
                                    )
                                
                            }
                            .buttonStyle(.plain)
                            
                            Text(cat.title)
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                        }
                    }
                }.padding(10)
            }
        }
    }
}

#Preview {
    TopCatagorySection()
}
