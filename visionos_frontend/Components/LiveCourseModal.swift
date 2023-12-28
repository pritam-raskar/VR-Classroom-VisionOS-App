import SwiftUI

struct LiveCourseModal: View {
    @State var title: String
    @State var batchDescription: String
    @State var batchTiming: String
    @State var batchData: String
    @State var classLink: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text(title)
                .font(.system(size: 11))
                .bold()
            
            VStack {
                Text(batchDescription)
                    .font(.system(size: 6))
                    .fontWeight(.light)
                    .frame(width: 60, height: 12)
                    .foregroundStyle(.white)
            }
            .background(Color.white.opacity(0.2))
            .foregroundColor(.black)
            .cornerRadius(3.0)
            
            HStack(alignment: .center, spacing: 25) {
                HStack(spacing: 5) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(batchTiming)
                        .font(.system(size: 8))
                }
                HStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(batchData)
                        .font(.system(size: 8))
                }
            }
            
            VStack {
                Text(batchDescription)
                    .font(.system(size: 6))
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 12)
            }
            .background(Color.red.opacity(0.3))
            .foregroundColor(.black)
            .cornerRadius(3.0)
            
            NavigationLink(destination: WebViewScreenView(roomId: classLink)) {
                Text("Join Now")
                    .font(
                        Font.custom("SF Pro Display", size: 10)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 230, height: 20, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black.opacity(0.4))
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(width: 250, height: 160)
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
    }
}


struct LiveCourseModal_Previews: PreviewProvider {
    static var previews: some View {
        LiveCourseModal(
            title: "How to Make an Array and its Types in C++",
            batchDescription: "BATCH 3CO - JVY",
            batchTiming: "12:34 PM",
            batchData: "Jan 1, 2023",
            classLink: "1234"
        )
    }
}
