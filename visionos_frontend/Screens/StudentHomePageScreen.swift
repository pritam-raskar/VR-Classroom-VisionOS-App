import SwiftUI

struct StudentHomePageScreen: View {
    @State private var cardDetailsArray = [courseCardDetails]()
    struct courseCardDetails: Codable {
        let id: Int
        let heading: String
        let subHeading: String
        let live_watching: Int
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    // Replace with a valid image
                    Image("thumbnail")
                        .resizable()
                    
                    VStack {
                        CourseHeaderStats()
                        Spacer()
                        CourseTitle()
                        
                        Spacer()
                
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(cardDetailsArray, id: \.id) { card in
                                    CourseCard(heading: card.heading, subHeading: card.subHeading, liveWatching: card.live_watching)
                                }
                            }.frame(maxWidth: .infinity)
                        }.padding(.horizontal, 4)
                            .padding(.bottom, 10)
                        
                    }
                    .frame(width: .infinity, height: 1025)
                }.background(Color.red)
                
                LearnMoreSection().padding(.bottom, 40)
                TopCatagorySection().padding(.bottom, 40)
            }
        }
        .task {
            await getCardDetails()
        }
        .tabItem {
            Label("Browser", systemImage: "command")
        }.tag(0)
    }
    
    func getCardDetails() async {
        let endpoint = "https://api.npoint.io/3ed15681b2d4ba45bdde"
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, error) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([courseCardDetails].self, from: data) {
                cardDetailsArray = decodedResponse
            } else {
                print(error)
                print("Failed to decode JSON")
            }
        } catch {
            print("Failed to Fetch the Request: \(error)")
        }
    }
}

#Preview(windowStyle: .plain) {
    NavigationStack {
        StudentHomePageScreen()
    }
}
