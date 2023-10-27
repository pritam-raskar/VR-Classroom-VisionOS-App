//
//  SettingsNavigationPanelList.swift
//  visionos_frontend
//
//  Created by Saikat Mukherjee on 27/10/23.
//

import SwiftUI

struct SettingsNavigationPanelList: View {
    var imageName: String
    var labelText: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
            Text(labelText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.leading,27)
    }
}

#Preview {
    SettingsNavigationPanelList(imageName: "user", labelText: "Account")
}
