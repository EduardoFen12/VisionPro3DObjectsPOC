//
//  XPGained.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct XPGained: View {
    var totalXP: Int = 10
    var body: some View {
        HStack(spacing: 4) {
            Image("XPIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 19)
            Text("\(totalXP) XP")
                .font(Fonts.Caption)
                .foregroundStyle(.answerBackground)
        }
        .padding(8)
        .frame(height: 28)
        .background(RoundedRectangle(cornerRadius: 64)
            .fill(.blueXPBackground)
        )
    }
}

#Preview {
    XPGained()
}
