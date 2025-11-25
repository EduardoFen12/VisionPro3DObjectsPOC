//
//  AnswerFeedbackSheet.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI
import CloudKit

struct AnswerFeedbackSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    var correctAnswer: String
    var isCorrect: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text(isCorrect ? "Correct! Well done,\nHistorian!" : "Not quite.\nHere's the right answer.")
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
                .font(Fonts.Title4)
                .foregroundStyle(.answerBackground)
            
            if !isCorrect {
                Text(String(localized: String.LocalizationValue(correctAnswer)))
                    .multilineTextAlignment(.center)
                    .font(Fonts.Body)
                    .foregroundStyle(.answerBackground)
                    .frame(width: 370)
                    .frame(minHeight: 45, maxHeight: 74)
                    .background(RoundedRectangle(cornerRadius: 2)
                        .fill(.greenFinal)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.greenInitial, lineWidth: 4)
                    )
            }
            
            if isCorrect {
                HStack(spacing: 4) {
                    Text(String(localized: String.LocalizationValue("You gained ")))
                        .font(Fonts.Body)
                        .foregroundStyle(.answerBackground)
                    XPGained()
                }
            } else {
                HStack(spacing: 4) {
                    Text("You lost ")
                        .font(Fonts.Body)
                        .foregroundStyle(.answerBackground)
                    AnaglyphHeart()
                    Text(" life.")
                        .font(Fonts.Body)
                        .foregroundStyle(.answerBackground)
                }
            }
                        
            Button {
                dismiss()
            } label: {
                AlternativeButton(description: "Continue", buttonColor: isCorrect ? .green : .red)
            }
            .padding(.top, 32)
            .padding(.horizontal)
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            
        }
        .padding(.top, 56)
        .frame(maxWidth: .infinity, minHeight: 320, maxHeight: 421)
        
    }
}
