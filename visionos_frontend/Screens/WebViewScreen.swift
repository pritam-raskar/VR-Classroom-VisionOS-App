//
//  WebViewScreen.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 10/11/23.
//

import SwiftUI
import WebKit

struct WebViewScreen: View {
    @State private var showWebView = false
    private let urlString = "http://localhost:5173"
    var body: some View {
        VStack(spacing:40){
            WebView(url: URL(string: urlString)!)
                .frame(width: .infinity, height: .infinity)
                .cornerRadius (10)
                .shadow(color: .black.opacity(0.3), radius: 20.0, x: 5, y: 5)
            
        }
        
    }
}
struct WebView:UIViewRepresentable{
    var url:URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url:url)
        uiView.load(request)
    }
}

#Preview {
    WebViewScreen()
    
}
