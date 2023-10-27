import SwiftUI

struct ContentView2: View {
    @State private var courses: [Course] = []
    
    var body: some View {
        NavigationView {
            List(courses, id: \.heading) { course in
                CourseCard5(course: course)
            }
            .onAppear {
                Task {
                    do {
                        if let loadedCourses = try await loadData() {
                            courses = loadedCourses
                        }
                    } catch {
                        print("Something Went Wrong")
                    }
                }
            }
            .navigationTitle("Courses")
        }
    }
    
    func loadData() async -> [Course]? {
        guard let url = URL(string: "https://api.npoint.io/9d3f810992ced9049b44") else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(CourseResponse.self, from: data).data
        } catch {
            return nil
        }
    }
}


struct CourseCard5: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.heading)
                .font(.title)
            Text(course.subHeading)
                .foregroundColor(.secondary)
//            Text("Live Watching: \(course.live_watching)")
//                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

struct CourseResponse: Codable {
    let data: [Course]
}

struct Course: Codable, Identifiable {
    var id = UUID()
    let heading: String
    let subHeading: String
//    let liveWatching: Int
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView2()
        }
    }
}
