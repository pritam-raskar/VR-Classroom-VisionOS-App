//
//  InstructorLiveClassessScreen.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 18/12/23.
//

import SwiftUI

struct InstructorLiveClassessScreen: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing:18) {
                ScrollView(.horizontal) {
                    HStack {
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                        LiveCourseModal()
                    }
                }
            }
        }
    }
}

#if DEBUG
struct InstructorLiveClassessScreen_Previews: PreviewProvider {
    static var previews: some View {
        InstructorLiveClassessScreen()
    }
}
#endif
