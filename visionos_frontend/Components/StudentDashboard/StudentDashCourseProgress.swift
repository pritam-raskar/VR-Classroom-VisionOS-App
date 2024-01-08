//
//  StudentDashCourseProgress.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 08/01/24.
//

import SwiftUI

struct ProgressBarView: View {
    var completedPercentage: CGFloat
    var incompletePercentage: CGFloat {
        return 100 - completedPercentage
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Completed portion
                Rectangle()
                    .frame(width: geometry.size.width * (completedPercentage / 100))
                    .foregroundColor(Color.green.opacity(0.3))

                // Incomplete portion
                Rectangle()
                    .frame(width: geometry.size.width * (incompletePercentage / 100))
                    .foregroundColor(Color.red.opacity(0.3))
            }
        }
        .cornerRadius(8)
        .overlay(
            HStack(alignment:.center) {
                // Display completed percentage
                Text("\(Int(completedPercentage))%")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.leading, 8)

                Spacer()

                // Display incomplete percentage
                Text("\(Int(incompletePercentage))%")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.trailing, 8)
            }
        )
        .padding(4)
    }
};
 struct StudentDashCourseProgress: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Lesson Name 01")
                    .font(.footnote)

                Spacer()

                // Add progress bar here
                ProgressBarView(completedPercentage: 70)
                    .frame(width:150, height: 30)
            }.frame(width: 260, height:100)
        }
        .frame(width: 300, height:80)
        .background(Color(red: 0.37, green: 0.62, blue: 1).opacity(0.1))

        .cornerRadius(30)
        .shadow(color: Color(red: 0.11, green: 0.11, blue: 0.11).opacity(0.2), radius: 13, x: 0, y: 15)
        .overlay(
        RoundedRectangle(cornerRadius: 30)
        .inset(by: 0.5)
        .stroke(.white.opacity(0.68), lineWidth: 0.4)

        )
    }
}

struct StudentDashCourseProgress_Previews: PreviewProvider {
    static var previews: some View {
        StudentDashCourseProgress()
    }
}

