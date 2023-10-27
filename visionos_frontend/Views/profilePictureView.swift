import SwiftUI

struct ProfilePictureView: View {
    let radius: CGFloat = 60
    
    var body: some View {
        let offset: CGFloat = sqrt(radius * radius / 2)
        
        return Image("profileImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: radius * 2, height: radius * 2)
            .clipShape(Circle())
            .overlay(
                Button(action: {}) {
                    Image(systemName: "camera")
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: offset, y: offset)
            )
    }
}

struct ProfilePictureViews_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView()
    }
}
