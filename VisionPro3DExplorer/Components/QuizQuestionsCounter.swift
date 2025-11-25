//
//  QuizQuestionsCounter.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct QuizQuestionsCounter: View {
    @Binding var currentQuestionIndex: Int
    var counter: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<counter, id: \.self) { index in
                ZStack {
                    symbol.foregroundColor(.heartBlue).offset(x: -1.5)
                    symbol.foregroundColor(.heartYellow).offset(x: -1.5)
                    symbol.foregroundColor(.heartRedGlow).offset(x: 1.5)
                    symbol.foregroundColor(.heartCyan).offset(x: 1.5)

                    symbol
                        .foregroundColor(index < currentQuestionIndex ? .heartRed : .heartWhite)
                        .blur(radius: 2)
                        .opacity(0.9)

                    symbol.foregroundColor(index < currentQuestionIndex ? .heartRed : .heartWhite)
                }
                .compositingGroup()
                .shadow(color: .black.opacity(0.55), radius: 2, x: 0, y: 2)
            }
        }
    }

    private var symbol: some View {
        Rectangle()
            .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 10)
    }
}
