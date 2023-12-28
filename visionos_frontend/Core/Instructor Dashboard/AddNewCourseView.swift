//
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 18/12/23.
//

import SwiftUI

struct NewCourseView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var duration = ""
    @State private var timing = ""
    @State private var image: Image? = nil
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(){
            Nabar(isInstructor: true, userName: "Pritam")
                .padding(.horizontal, 30)
                .padding(.vertical, 1)
            VStack(){
                Text("Add New Course")
                    .font(.largeTitle)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.1))
            Form {
                Section(header: Text("Image")) {
                    Button(action: {
                        presentImagePicker()
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Choose Image")
                        }
                        .foregroundColor(.white)
                    }
                    
                    if let image = image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    }
                }
                Section(header: Text("Course Details")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Course Title")
                        TextField("Enter course title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Duration")
                        TextField("Enter duration", text: $duration)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Timing")
                        TextField("Enter timing", text: $timing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                        TextEditor(text: $description)
                            .frame(minHeight: 100)
                            .padding(.leading, -5)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(15)
                        
                    }.padding(.bottom)
                }
                .listRowBackground(Color.black.opacity(0.2))
                
                
                
                Section {
                    Button(action: {
                        createCourse()
                    }) {
                        Text("Create Course")
                            .frame(maxWidth: .infinity)
                        //                            .padding()
                            .foregroundColor(.white)
                        //                            .background(isLoading ? Color.gray.opacity(0.8) : Color.gray)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(isLoading)
                }
            }
            .frame(width: 500, alignment: .center)
            .overlay(loadingOverlay)
            .alert("Success", isPresented: showAlert, actions: {
                Button("OK", role: .cancel) { }
            })
            .navigationTitle("New Course")
            .padding()
            .background(.white.opacity(0.1))
            .cornerRadius(10)
        }
    }
    
    
    func presentImagePicker() {
        // Implement using appropriate image picker
    }
    
    func createCourse() {
        isLoading = true
        errorMessage = ""
        
        // Validate input
        if title.isEmpty || description.isEmpty {
            errorMessage = "Please fill in all fields."
            isLoading = false
            return
        }
        
        // Upload image (if any)
//        uploadImageIfNeeded()
        
        // Send course data to server (or store locally)
        // Call your API or perform the necessary action here
        
        // For demonstration, simulate a network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            errorMessage = "Course created successfully!"
        }
    }
    
//    func uploadImageIfNeeded() {
//        // Implement image upload logic here
//    }
    
    var loadingOverlay: some View {
        ProgressView()
            .opacity(isLoading ? 1 : 0)
    }
    
    var showAlert: Binding<Bool> {
        Binding(
            get: { !errorMessage.isEmpty },
            set: { _ in errorMessage = "" }
        )
    }
}

struct NewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        
        NewCourseView()
        
        
    }
}
