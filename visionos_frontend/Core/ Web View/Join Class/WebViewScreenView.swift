//
//  WebViewScreen.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 10/11/23.
//

import SwiftUI
import WebKit

struct WebViewScreenView: View {
    @State private var showWebView = false
    @State var roomId: String
    
    // Use a computed property to dynamically generate the URL based on roomId
    private var urlString: String {
        return "http://localhost:5173/room/\(roomId)"
    }
    
    var body: some View {
        VStack(spacing:40){
            WebView(url: URL(string: urlString)!)
                .frame(width: .infinity, height: .infinity)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 20.0, x: 5, y: 5)
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    WebViewScreenView(roomId: "1234")
}
