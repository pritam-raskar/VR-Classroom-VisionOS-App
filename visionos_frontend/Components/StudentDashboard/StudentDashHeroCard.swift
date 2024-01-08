//
//  StudentDashHeroCard.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 08/01/24.
//

import SwiftUI

struct StudentDashHeroCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("ONLINE COURSE")
                    .font(.caption2)
                    .fontWeight(.light)
                Text("Sharpen Your Skills with Professional Online Courses")
                    .font(.title)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Button(action: {
                    print("Hi")
                }, label: {
                    HStack {
                        Image(.playButton)
                        Text("Join Now!")
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 5)
                            .foregroundColor(.white)
                    }
                })
                .tint(.blue)
            }
        }
        .padding()
        .frame(maxWidth: 910, maxHeight: 150, alignment: .topLeading)
        .background(Color(red: 0.37, green: 0.62, blue: 1).opacity(0.1))
        .cornerRadius(20)
        .shadow(color: Color(red: 0.11, green: 0.11, blue: 0.11).opacity(0.2), radius: 13, x: 0, y: 15)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(Color.white.opacity(0.68), lineWidth: 1)
        )
    }
}

struct StudentDashHeroCard_Previews: PreviewProvider {
    static var previews: some View {
        StudentDashHeroCard()
    }
}
