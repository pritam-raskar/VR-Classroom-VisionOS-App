import SwiftUI

struct InstructorLiveClassView: View {
    @State private var selection = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Live Classes")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.leading, 16) // Adjust the leading padding as needed
                
                Spacer() // Add a flexible spacer to push the button to the trailing edge
                
                Button(action: {
                    // Add action for the button here
                }) {
                    HStack {
                        Image(systemName: "plus.square") // Use the appropriate SF Symbol for the add icon
                            .font(.system(size: 20))
                        
                        Text("Add Classes")
                            .font(.system(size: 12))
                    }
                    .padding(8)
                    .background(Color.white) // Adjust the background color as needed
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .padding(.trailing, 16) // Adjust the trailing padding as needed
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(8)
            
            HStack {
                Picker(selection: $selection, label: Text("")) {
                    Text("Scheduled Classes")
                        .tag(0)
                    Text("Class History").tag(1)
                }
                .frame(width: 400)
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.gray.opacity(0.2))
                .clipShape(Capsule())
                .foregroundColor(selection == 0 ? .green : .gray)
                .font(.system(size: 15)) // Adjust the font size as needed
                .padding(.horizontal, 20)
                .padding(.vertical, 2)
                
                Spacer() // Add Spacer to push the Picker to the left
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))], spacing: 13) {
                    ForEach(0..<36) { _ in
                        LiveCourseModal(
                            title: "How to Make an Array and its Types in C++",
                            batchDescription: "BATCH 3CO - JVY",
                            batchTiming: "12:34 PM",
                            batchData: "Jan 1,  2023"
                        )
                    }
                }
            }
        }
        .padding(.horizontal, 16) // Add even padding from left and right
    }
}

#if DEBUG
struct InstructorLiveClassessScreen_Previews: PreviewProvider {
    static var previews: some View {
        InstructorLiveClassView()
    }
}
#endif
