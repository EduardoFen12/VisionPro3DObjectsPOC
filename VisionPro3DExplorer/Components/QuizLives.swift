//
//  QuizLives.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct QuizLives: View {
    @Binding var lives: Int
    let totalLives: Int = 3
    var sizeW: CGFloat = 26
    var sizeH: CGFloat = 26

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalLives, id: \.self) { index in
                ZStack {
                    symbol.foregroundColor(.heartBlue).offset(x: -1.5)
                    symbol.foregroundColor(.heartYellow).offset(x: -1.5)
                    symbol.foregroundColor(.heartRedGlow).offset(x: 1.5)
                    symbol.foregroundColor(.heartCyan).offset(x: 1.5)

                    symbol
                        .foregroundColor(index < lives ? .heartRed : .heartWhite)
                        .blur(radius: 2)
                        .opacity(0.9)

                    symbol.foregroundColor(index < lives ? .heartRed : .heartWhite)
                }
                .compositingGroup()
                .shadow(color: .black.opacity(0.55), radius: 2, x: 0, y: 2)
            }
        }
    }

    private var symbol: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .font(.system(size: 16))
            .scaledToFit()
            .frame(width: sizeW, height: sizeH)
    }
}
