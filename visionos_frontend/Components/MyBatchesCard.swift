//
//  MyBatchesCard.swift
//  VisionOS Frontend
//
//  Created by Saikat Mukherjee on 27/12/23.
//

import SwiftUI

struct MyBatchesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("3 CO - JVY")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .bold()
            
            VStack(alignment: .leading, spacing: 5) {
                Text("25 Subjects")
                Text("250 Students")
                Text("2560 Quizzes")
                Text("25 Exams")
                Text("85 Assignments")
            }
            .font(.system(size: 8))
            .foregroundColor(.white.opacity(0.8))
            
            Button(action: {
                // Add your action here
            }) {
                Text("Batch Ends at 02 Jan 2027")
                    .font(
                        .custom("SF Pro Display", size: 10)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 180, height: 25, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black.opacity(0.4))
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
        .frame(width: 200, height: 160)
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
    }
}

struct MyBatchesCard_Previews: PreviewProvider {
    static var previews: some View {
        MyBatchesCard()
    }
}
