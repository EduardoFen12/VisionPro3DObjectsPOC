//
//  ScoreGauge.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct ScoreGauge: View {
    var score: Double
    var maxScore: Double = 500
    
    var progress: Double {
        min(score / maxScore, 1.0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.64)
                .rotation(Angle(degrees: 156))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .foregroundColor(Color.gray.opacity(0.3))
                .frame(width: 242, height: 242)
            
            Circle()
                .trim(from: 0.0, to: progress * 0.64)
                .rotation(Angle(degrees: 156))
                .stroke(AngularGradient(
                    gradient: Gradient(colors: [.blueXPBackground]),
                    center: .center),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 242, height: 242)
                .animation(.easeOut(duration: 1.0), value: progress)
            
            VStack(spacing: 8) {
                Text("TOTAL SCORE")
                    .font(Fonts.Body2)
                    .foregroundColor(.answerBackground)
                Text("\(Int(score))")
                    .font(Fonts.Title1)
                    .foregroundColor(.answerBackground)
            }
        }
        .padding()

    }
}
