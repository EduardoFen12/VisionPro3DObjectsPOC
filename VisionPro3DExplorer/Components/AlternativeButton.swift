//
//  AlternativeButton.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import SwiftUI

struct AlternativeButton: View {
    var description: String
    var buttonColor: ButtonColors
    var isHomeButton: Bool = false
    
    var body: some View {
        ZStack {
            if isHomeButton {
                Image("ImageMetalButton")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, minHeight: 72, maxHeight: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            
            Text(LocalizedStringKey(description))
                .font(isHomeButton ? Fonts.Title2 : Fonts.Button)
                .textCase(.uppercase)
                .foregroundStyle(isHomeButton ? .playNowButton : .white)
                .shadow(color: .black, radius: 0, x: (isHomeButton ? -2 : 0), y: 0) // Esquerda
                .shadow(color: .black, radius: 0, x: (isHomeButton ? 2 : 0), y: 0)  // Direita
                .shadow(color: .black, radius: 0, x: 0, y: (isHomeButton ? -2 : 0)) // Acima
                .shadow(color: .black, radius: 0, x: 0, y: (isHomeButton ? 2 : 0))  // Abaixo
                .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                .background(RoundedRectangle(cornerRadius: 4)
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [buttonColor.initialColor, buttonColor.finalColor]),
                        center: .center,
                        startRadius: 50,
                        endRadius: 150
                )))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, minHeight: 72, maxHeight: 72)
        .background(RoundedRectangle(cornerRadius: 8).fill(RadialGradient(
            gradient: Gradient(colors: [Color.white, Color.gray]),
            center: .center,
            startRadius: 50,
            endRadius: 150)))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
//        .padding(.horizontal)
    }
}

#Preview {
    AlternativeButton(description: "continue", buttonColor: .blackDesabled)
}
