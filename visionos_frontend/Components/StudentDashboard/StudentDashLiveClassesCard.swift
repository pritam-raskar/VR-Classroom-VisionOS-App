//
//  StudentDashLiveClassesCard.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 08/01/24.
//


import SwiftUI
struct ProgressBarView2: View {
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
                    .foregroundColor(Color.blue.opacity(0.7))

                // Incomplete portion
                Rectangle()
                    .frame(width: geometry.size.width * (incompletePercentage / 100))
                    .foregroundColor(Color.white.opacity(0.2))
            }
        }
        .cornerRadius(8)
        .padding(4)
    }
};

struct StudentDashLiveClassesCard: View {
    @State var cardThumbnailImage: String
    @State var courseTitle: String
    @State var description : String
    @State var specilizationDetails : String
    
    
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Image(cardThumbnailImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 180)
            }
            .frame(width: 331)
            .background(.univcolor)
                
                

                
            VStack(alignment: .leading, spacing: 10) {
                Text(courseTitle)
                    .font(.system(size: 24))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(description)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                ProgressBarView2(completedPercentage: 70)
                    .frame(height: 15)
                Spacer()
                
                HStack(spacing: 3) {
                    Text("PR")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .frame(width: 28, height: 28)
                        .background(Color(.systemGray))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    Text("Jhon Doe")
                
                }
            }
            .padding(20)
        }
        .frame(width: 280, height: 380)
        .glassBackgroundEffect()
            
    }
}

#Preview {
    StudentDashLiveClassesCard(
        cardThumbnailImage: "university",
        courseTitle: "Leading Teams: Developing as a Leader",
        description: "University of Pennsylvania",
        specilizationDetails: "SPECILIZATION (5 COURSE)"
    )
}
