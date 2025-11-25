//
//  LauncherView.swift
//  VisionPro3DExplorer
//
//  Created by Assistant on 19/11/25.
//

import SwiftUI

struct LauncherView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    @State private var opened = false

    var body: some View {
        ZStack {

        }
        .task {
            // Garante que só chamamos uma vez
            guard !opened else { return }
            opened = true
            _ = await openImmersiveSpace(id: "MainImmersive")
            // Opcional: você pode fechar/ocultar esta janela depois de abrir o espaço.
            // Em visionOS, normalmente deixamos a janela quieta ou minimizada.
        }
    }
}

#Preview {
    LauncherView()
}
