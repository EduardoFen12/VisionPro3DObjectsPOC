//
//  QuizResult.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


enum QuizResult {
    case lost
    case won
    
    var title: String {
        switch self {
        case .lost:
            return "Game over, out of lives!"
        case .won:
            return "Well done, historian!"
        }
    }
    
    var description: String {
        switch self {
        case .lost:
            return "You ran out of lives this round, but you learned a lot. Ready to try again?"
        case .won:
            return "Here are your results from this round"
        }
    }
    
    var buttonText: String {
        switch self {
        case .lost:
            return "Try Again"
        case .won:
            return "Continue"
        }
    }
}
