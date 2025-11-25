//
//  QuizSummaryView.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import CloudKit
import SwiftUI

struct QuizSummaryView: View {
    @Bindable var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss

    private var result: QuizResult {
        viewModel.quizResult ?? .lost
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(String(localized: String.LocalizationValue(result.title)))
                .textCase(.uppercase)
                .font(Fonts.Title4)
                .foregroundStyle(.answerBackground)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            Text(String(localized: String.LocalizationValue(result.description)))
                .font(Fonts.Body2)
                .foregroundStyle(.answerBackground)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            VStack(spacing: -48) {
                ScoreGauge(score: Double(viewModel.correctAnswersCount) * 100)

                HStack {
                    Text(String(localized: "You gained"))
                        .font(Fonts.Body2)
                        .foregroundStyle(.answerBackground)

                    XPGained(totalXP: Int(viewModel.correctAnswersCount * 10))
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(String(localized: "Correct Answers"))
                        .font(Fonts.badgeDescription)
                        .foregroundStyle(.answerBackground)
                    Text("\(viewModel.correctAnswersCount)")
                        .font(Fonts.Title5)
                        .foregroundStyle(.answerBackground)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Color.answerBackground
                    .frame(width: 2, height: 64)
                    .padding()

                VStack(spacing: 4) {
                    Text(String(localized: "Total\nTime"))
                        .font(Fonts.badgeDescription)
                        .foregroundStyle(.answerBackground)
                    Text("\(viewModel.formatMinutesAndSeconds(viewModel.totalTime))")
                        .font(Fonts.Title5)
                        .foregroundStyle(.answerBackground)
                }
                .frame(maxWidth: .infinity)

                Color.answerBackground
                    .frame(width: 2, height: 64)
                    .padding()

                VStack(alignment: .center, spacing: 4) {
                    Text(String(localized: "Avg.\nResponse"))
                        .font(Fonts.badgeDescription)
                        .foregroundStyle(.answerBackground)
                        .multilineTextAlignment(.center)
                    Text("\(viewModel.formatOnlySeconds(viewModel.averageTimePerQuestion))")
                        .font(Fonts.Title5)
                        .foregroundStyle(.answerBackground)
                }
                .frame(maxWidth: .infinity)

            }
            .frame(maxWidth: .infinity, minHeight: 75, maxHeight: 75)
            .padding(.horizontal)
            .padding(.bottom, 32)

            Button {
                Task {
                    self.viewModel.dismissToggle()
                    dismiss()
                }
            } label: {
                
                AlternativeButton(description: String(localized: "WORLD"), buttonColor: .blackEnabled)
                    .padding(.horizontal)
            }

        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.headerBackground)
    }
}
