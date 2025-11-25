//
//  QuizView.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//

import CloudKit
import SwiftUI

struct QuizView: View {
    @State var viewModel: QuizViewModel
    @State var isContinueTapped: Bool = false
    @State var isAnswerVerified: Bool = false
    @State private var refresh: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            if let question = viewModel.currentQuestion {
                ZStack {
//                    Image("MapPapperBackground")
//                        .resizable()
//                        .scaledToFit()
                    
                    VStack(spacing: 22) {
                        VStack(spacing: 16) {
                            HStack {
                                VStack(spacing: 0) {
                                    QuizQuestionsCounter(
                                        currentQuestionIndex: .constant(
                                            viewModel.currentQuestionIndex + 1
                                        ),
                                        counter: viewModel.questionsWithAnswers.count
                                    )
                                    
                                    HStack {
                                        Text(
                                            "\(viewModel.currentQuestionIndex+1)/\(viewModel.questionsWithAnswers.count) \(String(localized: "Question"))"
                                        )
                                        
                                        .font(Fonts.Body2)
                                        .foregroundStyle(.answerBackground)
                                        .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                        
                                        QuizLives(lives: .constant(viewModel.lives))
                                            .padding(.top, 8)
                                    }
                                }
                            }
                            .padding(.top, 64)
                            
                            Text(String(localized: String.LocalizationValue(question.text)))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            //                                    .textCase(.uppercase)
                                .font(Fonts.Title3)
                                .foregroundStyle(.answerBackground)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 16)
                                .scrollIndicators(.hidden)
                            
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, minHeight: 215)
                        .background(.headerBackground)
                        
                        VStack(spacing: 24) {
                            ForEach(viewModel.currentAnswers, id: \.id) { answer in
                                AnswerComponent(
                                    answerText: answer.text,
                                    isSelected: viewModel.selectedAnswer?.id == answer.id,
                                    action: {
                                        viewModel.selectAnswer(answer)
                                        Task {
                                            await viewModel.verifyAnswer(
                                                isSelectedAnswerCorrect: answer.isCorrect
                                            )
                                            isAnswerVerified = true
                                            viewModel.isShowingFeedbackModal = true
                                        }
                                        refresh.toggle()
                                    },
                                    isCorrect: isAnswerVerified && viewModel.correctAnswer?.id == answer.id,
                                    isVerified: $isAnswerVerified
                                )
                            }
                            Spacer()
                            
                        }
                        .navigationTitle("Quiz")
                        .toolbar(.hidden, for: .navigationBar)
                        .sheet(
                            isPresented: $viewModel.isShowingFeedbackModal,
                            onDismiss: {
                                Task {
                                    await viewModel.proceedAfterFeedback()
                                    isAnswerVerified = false
                                    refresh.toggle()
                                }
                            }
                        ) {
                            AnswerFeedbackSheet(
                                correctAnswer: viewModel.correctAnswer?.text ?? "Resposta certa não encontrada",
                                isCorrect: viewModel.isCorrect ?? false
                            )
                            .presentationDetents([
                                (viewModel.isCorrect ?? false ? .height(320) : .height(425)),
                                .medium, .large,
                            ])
                            .preferredColorScheme(.dark)
                        }
                        
                        .navigationDestination(isPresented: $viewModel.navigateToSummary) {
                            QuizSummaryView(viewModel: viewModel)
                        }
                    }
                }
                .background(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .glassBackgroundEffect()
                
            } else {
                Text("Questionnaire not found!!!")
                    .foregroundStyle(.red)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    QuizView(viewModel: QuizViewModel())
}
