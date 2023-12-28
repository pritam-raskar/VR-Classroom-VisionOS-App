//
//  MyTasksModal.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 27/12/23.
//

import SwiftUI

struct MyTasksCard: View {
    @State var taskTitle :String
    @State var assignTime : String
    @State var assignDate : String
    @State var dueTime : String
    @State var dueDate : String
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(taskTitle)
                .font(.system(size: 11))
                .bold()
                .frame(width:.infinity,height: 30)
 
            HStack(alignment: .center, spacing:10 ) {
                HStack(){
                    Text("Assigned")
                        .font(Font.custom("SF Pro Display", size: 10))
                        .foregroundColor(.white.opacity(0.7))
                        .frame(minWidth: 50,alignment: .leading)
                }
                HStack(spacing:5){
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(assignTime)
                        .font(.system(size: 8))
                }
                HStack(spacing:5){
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(assignDate)
                        .font(.system(size: 8))
                }
            }
            
            HStack(alignment: .center, spacing:10 ) {
                HStack(){
                    Text("Due")
                        .frame(minWidth: 50,alignment: .leading)
                        .font(Font.custom("SF Pro Display", size: 10))
                        .foregroundColor(.white.opacity(0.7))
                }
                HStack(spacing:5){
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(dueTime)
                        .font(.system(size: 8))
                }
                HStack(spacing:5){
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Text(dueDate)
                        .font(.system(size: 8))
                }
            }
            
            VStack {
                Text("Not Started")
                    .font(Font.custom("SF Pro Display", size: 8))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                    .cornerRadius(35)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 15)
                   
            }
            .background(Color.white.opacity(0.2))
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
                    .frame(width: 330, height: 20, alignment: .center)
                
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black.opacity(0.4))
                        //                            .border(Color.clear, width: 0) // Set border color to clear
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding() // Add padding around the content
        .frame(width: 350, height: 180)
        .background(Color.black.opacity(0.2)).edgesIgnoringSafeArea(.all)
        .cornerRadius(15)
    }
}


#Preview {
    MyTasksCard(
        taskTitle: "Add a Quiz for Students of 3CO - JVY on the subject \n Fundamentals of Programming",
        assignTime: "12:34 PM",
        assignDate: "Jan 1, 2023",
        dueTime: "12:35 PM",
        dueDate: "Jan 1, 2023"
    )
}
