import SwiftUI

struct NewCourseScreenView: View {
    @State private var duration = ""
    @State private var selectedOption1 = 0
    @State private var selectedOption2 = 0
    @State private var selectedOption3 = 0
    @State private var selectedOption4 = 0

    let options = ["Option 1", "Option 2", "Option 3", "Option 4"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                if duration.isEmpty {
                    Text("Enter duration...")
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                }
                
                TextEditor(text: $duration)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 800, height: 80)
                    .border(Color.gray, width: 1)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(20)
            }
            
            VStack(alignment:.center) {
                HStack{
                    Text("Select Course:")
                    Picker("Dropdown 2", selection: $selectedOption1) {
                        ForEach(0..<options.count) {
                            Text(self.options[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    Spacer()
                    Text("Select Course:")
                    Picker("Dropdown 2", selection: $selectedOption2) {
                        ForEach(0..<options.count) {
                            Text(self.options[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
                HStack{
                    Text("Select Course:")
                    Picker("Dropdown 3", selection: $selectedOption3) {
                        ForEach(0..<options.count) {
                            Text(self.options[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    Spacer()
                    Text("Select Course:")
                    Picker("Dropdown 4", selection: $selectedOption4) {
                        ForEach(0..<options.count) {
                            Text(self.options[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
            }
            .frame(width:800)
            Spacer()
        }
    }
}

struct NewCourseScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NewCourseScreenView()
    }
}
