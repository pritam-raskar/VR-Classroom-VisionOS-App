import SwiftUI
struct LiveCourseModal: View {
    @State var title: String
    @State var batchDescription: String
    @State var batchTiming : String
    @State var batchData : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("How to Make an Array and its Types in C++")
                .font(.system(size: 11))
                .bold()
            
            VStack {
                Text("Batch 3CO - JVY")
                    .font(.system(size: 6))
                    .fontWeight(.light)
                    .frame(width: 60, height: 12)
                    .foregroundStyle(.white)
            }
            .background(Color.white.opacity(0.2))
            .foregroundColor(.black)
            .cornerRadius(3.0)
            
            HStack(alignment: .center, spacing:25 ) {
                HStack(spacing:5){
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text("12:34 PM")
                        .font(.system(size: 8))
                }
                HStack(spacing:5){
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text("Jan 1, 2023")
                        .font(.system(size: 8))
                }
            }
            
            VStack {
                Text("Batch 3CO - JVY")
                    .font(.system(size: 6))
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 12)
            }
            .background(Color.red.opacity(0.3))
            .foregroundColor(.black)
            .cornerRadius(3.0)
            
            Button(action: {
                // Add your action here
            }) {
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
                        //                            .border(Color.clear, width: 0) // Set border color to clear
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding() // Add padding around the content
        .frame(width: 250, height: 160)
        .background(Color.black.opacity(0.2)).edgesIgnoringSafeArea(.all)
        .cornerRadius(15)
    }
}


struct LiveCourseModal_Previews: PreviewProvider {
    static var previews: some View {
        LiveCourseModal(
            title: "How to Make an Array and its Types in C++",
            batchDescription: "BATCH 3CO - JVY",
            batchTiming: "12:34 PM",
            batchData: "Jan 1,  2023"
        )
    }
}
