//
//  CourseCard2.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import SwiftUI

struct CourseCard2: View {
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Image(.university)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 160)
            }
            .frame(width: 331)
            .background(.univcolor)
                
                

                
            VStack(alignment: .leading, spacing: 10) {
                Text("Interlocution to Programming with Python and Java")
                    .font(.system(size: 24))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text("University of Pennsylvania")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                Spacer()
                
                Text("SPECILIZATION (4 COURSE)")
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
    CourseCard2()
}
