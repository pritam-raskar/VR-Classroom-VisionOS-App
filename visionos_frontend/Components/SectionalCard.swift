//
//  SectionalCard.swift
//  visionos_frontend
//
//  Created by Abir Pal on 28/12/23.
//

import SwiftUI

struct SectionalCard: View {
    @State var cardImage : String
    @State var title : String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Button(action: {
                print("Hi")
            }) {
                VStack {
                    Image(cardImage)
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
            
            Text(title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        }
    }
}

#Preview {
    SectionalCard(cardImage: "image1", title: "Design")
}
