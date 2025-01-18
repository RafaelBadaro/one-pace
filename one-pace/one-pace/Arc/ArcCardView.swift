//
//  ArcCardView.swift
//  one-pace
//
//  Created by Rafael Badaró on 18/01/25.
//

import SwiftUI

struct ArcCardView: View {
    
    let arcName: String
    
    var body: some View {
        HStack {
            Text(arcName)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        // TODO: fazer as cores estarem dentro de um tema e não hardcoded
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "FDC719"),
                    Color(hex: "FB0011")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )        .cornerRadius(15)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    ArcCardView(arcName: "Romance Dawn")
}
