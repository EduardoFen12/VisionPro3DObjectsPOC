//
//  AnaglyphHeart.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct AnaglyphHeart: View {
    var body: some View {
        ZStack {
            symbol.foregroundColor(.heartBlue).offset(x: -1)
            symbol.foregroundColor(.heartYellow).offset(x: -1)
            symbol.foregroundColor(.heartRedGlow).offset(x: 1)
            symbol.foregroundColor(.heartCyan).offset(x: 1)

            symbol
                .foregroundColor(.heartRed)
                .blur(radius: 2)
                .opacity(0.9)

            symbol.foregroundColor(.heartRed)
        }
        
    }
    
    private var symbol: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .font(.system(size: 16))
            .scaledToFit()
            .frame(width: 26, height: 26)
    }
}

#Preview {
    AnaglyphHeart()
}
