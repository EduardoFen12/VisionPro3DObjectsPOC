//
//  QuizViewModel.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//

import Foundation

@Observable
class QuizViewModel {
    
    private let quizService: QuizService
    var onQuizCompleted: (() -> Void)?
    
    var questionsWithAnswers: [(question: Question, answers: [Answer])] = []
    var currentQuestionIndex: Int = 0
    var selectedAnswer: Answer? = nil
    var isCorrect: Bool? = nil
    var showCorrectAnswer: Bool = false
    var errorMessage: String? = nil
    var lives: Int = 3
    let totalLives: Int = 3
    var isShowingFeedbackModal = false
    var isAnswerVerified = false
    
    var dismiss: Bool = false
    
    var startTime: Date?
    var endTime: Date?
    var correctAnswersCount: Int = 0
    var isFinished = false
    
    var quizResult: QuizResult? = nil
    var navigateToSummary = false
    
    var navigateBackToHome = false
    
    var totalTime: TimeInterval {
        guard let start = startTime else { return 0 }
        let end = endTime ?? Date()
        return end.timeIntervalSince(start)
    }

    var averageTimePerQuestion: TimeInterval {
        guard questionsWithAnswers.count > 0 else { return 0 }
        return totalTime / Double(questionsWithAnswers.count)
    }
    
    var currentQuestion: Question? {
        guard !questionsWithAnswers.isEmpty,
            currentQuestionIndex < questionsWithAnswers.count
        else { return nil }
        return questionsWithAnswers[currentQuestionIndex].question
    }
    
    var currentAnswers: [Answer] {
        guard !questionsWithAnswers.isEmpty,
            currentQuestionIndex < questionsWithAnswers.count
        else { return [] }
        return questionsWithAnswers[currentQuestionIndex].answers
    }
    
    var correctAnswer: Answer? {
        currentAnswers.first(where: { $0.isCorrect })
    }
    
    
    init (
        quiService: QuizService = QuizService(),
        onQuizCompleted: (() -> Void)? = nil
    ) {
        self.quizService = quiService
        self.onQuizCompleted = onQuizCompleted
        loadQuiz()
    }
    
    func loadQuiz() {
        self.questionsWithAnswers = self.quizService.database
        self.currentQuestionIndex = 0
        self.lives = self.totalLives
        self.correctAnswersCount = 0
        self.startTime = Date()
        self.endTime = nil
    }
    
    func selectAnswer(_ answer: Answer) {
        selectedAnswer = answer
    }
    
    func verifyAnswer(isSelectedAnswerCorrect: Bool) async {
        if isSelectedAnswerCorrect {
            isCorrect = true
            showCorrectAnswer = false
            correctAnswersCount += 1
        } else {
            isCorrect = false
            showCorrectAnswer = true
            await loseLife()
        }
    }
    
    func loseLife() async {
        if lives > 0 {
            lives -= 1
        }
    }
    
    func nextQuestion() async {
        selectedAnswer = nil
        isCorrect = nil
        showCorrectAnswer = false
        if currentQuestionIndex < questionsWithAnswers.count - 1 {
            currentQuestionIndex += 1
        } else {
            finishQuiz()
        }
    }
    
    func proceedAfterFeedback() async {
        if isCorrect == true {
            await nextQuestion()
            return
        }

        if lives == 0 {
            finishQuiz()
        } else {
            await nextQuestion()
        }
    }

    func resetLives() {
        lives = totalLives
    }

    func finishQuiz() {
        if endTime == nil { endTime = Date() }
        isFinished = true

        if lives > 0 {
            quizResult = .won
        } else {
            quizResult = .lost
        }

        navigateToSummary = true
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func formatMinutesAndSeconds(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    func formatOnlySeconds(_ time: TimeInterval) -> String {
        let seconds = Int(time.rounded())
        return "\(seconds) SEC"
    }
    
    func dismissToggle() {
        self.dismiss.toggle()
    }

}
