//
//  VisionPro3DExplorerApp.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 17/10/25.
//

import SwiftUI

@main
struct VisionPro3DExplorerApp: App {

    var body: some Scene {

        // Janela inicial (launcher) — abre o ImmersiveSpace automaticamente
        WindowGroup {
            LauncherView()
        }
        .defaultSize(width: 600, height: 400)
        .windowResizability(.automatic)
        .windowStyle(.plain)

        // Janela 2D que apresentará a sua QuizView sob demanda
        WindowGroup(id: "QuizWindow") {
            QuizView(viewModel: QuizViewModel())
        }
        .defaultSize(width: 800, height: 700)
        .windowResizability(.automatic)
        .windowStyle(.plain)

        // Espaço imersivo principal
        ImmersiveSpace(id: "MainImmersive") {
            MainImmersiveView()
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
