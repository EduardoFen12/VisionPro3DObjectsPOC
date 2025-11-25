//
//  AnswerComponent.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//

import SwiftUI

struct AnswerComponent: View {
    
    let baseColor: Color = .answerBackground
    let baseColorBoder: Color = .answerBackgroundBorder
    var selectedColorBoder: Color {
        if isVerified && isCorrect {
            return .selectedCorrectAnswerBackgroundBorder
        } else if isVerified && !isCorrect {
            return .selectedWrongAnswerBackgroundBorder
        } else {
            return .selectedAnswerBackgroundBorder
        }
    }
    var selectedColor: Color {
        if isVerified && isCorrect {
            return .selectedCorrectAnswerBackground
        } else if isVerified && !isCorrect {
            return .selectedWrongAnswerBackground
        } else {
            return .selectedAnswerBackground
        }
    }
    let selectedAnswerFontColor: Color = .selectedAnswerText
    
    let answerText: String
    let isSelected:  Bool
    let action: () -> Void
    var isCorrect: Bool = false
    @Binding var isVerified: Bool
    
    @State private var isMultiLine = false
    
    
    var body: some View {
            HStack {
                Text(String(localized: String.LocalizationValue(answerText)))
                    .foregroundStyle( isSelected ? selectedAnswerFontColor : .black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(Fonts.Title5)
                    .padding(.horizontal, 24)
            }
            .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
            .background(
                ZStack {
                    (isSelected ? selectedColor : baseColor)
                    NoiseBackground()
                        .blendMode(.overlay)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(isSelected ? selectedColorBoder : baseColorBoder, lineWidth: 2)
            )
            .shadow(radius: 4)
            .onTapGesture {
                withAnimation(.easeInOut){
                    action()
                }
            }
            .padding(.horizontal)
            .allowsHitTesting(!isVerified)
        }
}
struct NoiseBackground: View {
    var body: some View {
        Canvas { context, size in
            for _ in 0..<2000 {
                let x = CGFloat.random(in: 0..<size.width)
                let y = CGFloat.random(in: 0..<size.height)
                let rect = CGRect(x: x, y: y, width: 1, height: 1)
                context.fill(Path(rect), with: .color(.black.opacity(0.15)))
            }
        }
    }
}
