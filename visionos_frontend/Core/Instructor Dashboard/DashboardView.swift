//
//  Dashboard.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 27/12/23.
//

import SwiftUI

struct DashboardView: View {
    @State private var selection = 0
    let liveCourseCount = 5
    let myTasksCount = 4
    let myBatchesCount = 6
    enum Flavor: String, CaseIterable, Identifiable {
        case All,notStarted = "Not Started", Ongoing, Completed,Missed
        var id: Self { self }
    }


    @State private var selectedFlavor: Flavor = .All

    var body: some View {
        VStack{
            Nabar(isInstructor: true, userName: "Pritam")
                .padding(.horizontal, 30)
                .padding(.vertical, 1)
            HStack {
                
                // ScrollView for Live Classes
                VStack(alignment: .leading) {
                    Text("Live Classes")
                        .font(.system(size: 20))
                        .bold()
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<liveCourseCount, id: \.self) { _ in
                            LiveCourseModal(
                                title: "How to Make an Array and its Types in C++",
                                batchDescription: "BATCH 3CO - JVY",
                                batchTiming: "12:34 PM",
                                batchData: "Jan 1,  2023",
                                classLink: "1234"
                            )
                        }
                    }
                }
                .padding()
                
                // ScrollView for My Tasks
                
                VStack(alignment:.leading) {
                    Text("My Tasks")
                        .font(.system(size: 20))
                        .bold()
                    Picker("Flavor", selection: $selectedFlavor) {
                          ForEach(Flavor.allCases) { flavor in
                              Text(flavor.rawValue.capitalized)
                                  .font(.system(size: 5))
                          }
                          
                      }.pickerStyle(.segmented)
                        .frame(width: 350)
                    ScrollView (showsIndicators: false) {
                        ForEach(0..<myTasksCount, id: \.self) { _ in
                            MyTasksCard(
                                taskTitle: "Add a Quiz for Students of 3CO - JVY on the subject \n Fundamentals of Programming",
                                assignTime: "12:34 PM",
                                assignDate: "Jan 1, 2023",
                                dueTime: "12:35 PM",
                                dueDate: "Jan 1, 2023"
                            )
                        }
                    }
                }
                .padding()
                
                // ScrollView for My Batches
                
                VStack(alignment: .leading){
                    Text("My Batches")
                        .font(.system(size: 20))
                        .bold()
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<myBatchesCount, id: \.self) { _ in
                            MyBatchesCard()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
