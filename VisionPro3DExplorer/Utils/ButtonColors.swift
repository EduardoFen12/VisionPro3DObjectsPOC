//
//  ButtonColors.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import Foundation
import SwiftUI

enum ButtonColors {
    case green
    case red
    case blackEnabled
    case blackDesabled
    
    var initialColor: Color {
        switch self {
        case .green:
            return .greenInitial
        case .red:
            return .redInitial
        case .blackEnabled:
            return .blackEnabledInitial
        case .blackDesabled:
            return .blackDisabledInitial
        }
    }
    
    var finalColor: Color {
        switch self {
        case .green:
            return .greenFinal
        case .red:
            return .redFinal
        case .blackEnabled:
            return .blackEnabledFinal
        case .blackDesabled:
            return .blackDisabledFinal
        }
    }
}
