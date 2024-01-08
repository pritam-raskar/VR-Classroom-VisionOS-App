//
//  StudentDashboardView.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 08/01/24.
//

import SwiftUI

struct StudentDashboardView: View {
    var body: some View {
        Nabar(isInstructor: true, userName: "Pritam")
            .padding(.horizontal, 30)
            .padding(.vertical, 1)
        ScrollView {
            VStack(alignment: .leading) {
                StudentDashHeroCard()
                    .padding(.bottom, 10)
                Text("Course Progress")
                    .font(.largeTitle)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<6) { _ in
                            StudentDashCourseProgress()
                            .padding(.trailing,10)                        }
                    }
                }
                Text("Live Classes")
                    .font(.largeTitle)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<6) { _ in
                            StudentDashLiveClassesCard(
                                cardThumbnailImage: "university",
                                courseTitle: "Leading Teams: Developing as a Leader",
                                description: "University of Pennsylvania",
                                specilizationDetails: "SPECIALIZATION (5 COURSES)"
                            )
                            .padding(.trailing,10)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    StudentDashboardView()
}
