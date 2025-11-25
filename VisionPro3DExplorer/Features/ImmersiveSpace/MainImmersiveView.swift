//
//  MainImmersiveView.swift
//  VisionPro3DExplorer
//
//  Created by Assistant on 19/11/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MainImmersiveView: View {

    @Environment(\.openWindow) private var openWindow
    
    @State private var macbookEntity: Entity?

    var macbookTapGesture: some Gesture {
        TapGesture()
            .targetedToAnyEntity() // Aplica a qualquer entidade com collision
            .onEnded { value in
                if value.entity.name == "MacBook" { // Checa se foi o MacBook clicado
                    openWindow(id: "QuizWindow")
                }
            }
    }

    var body: some View {
        ZStack {
            // Conteúdo 3D
            RealityView { content in
                // 1) Skybox simulado com esfera invertida e textura panorâmica
                if
                    let uiImage = UIImage(named: "ThirdIndustrialRevolution3D"),
                    let cgImage = uiImage.cgImage
                {
                    do {
                        let texture = try await TextureResource(
                            image: cgImage,
                            options: TextureResource.CreateOptions(semantic: .color)
                        )
                        let mesh = MeshResource.generateSphere(radius: 5)
                        var material = UnlitMaterial()
                        material.baseColor = .texture(texture) // Usa a textura panorâmica
                        let skyboxSphere = ModelEntity(mesh: mesh, materials: [material])
                        skyboxSphere.scale.x = -1 // Inverte a esfera, tornando a face interna visível
                        content.add(skyboxSphere)
                    } catch {
                        print("Falha ao criar TextureResource para o skybox: \(error)")
                    }
                } else {
                    print("Imagem 'ThirdIndustrialRevolution3D' não encontrada nos Assets ou sem cgImage.")
                }

                // 2) Âncora na cabeça do usuário (sem chão)
                let headAnchor = AnchorEntity(.head)
                content.add(headAnchor)

                // 3) MacBook ancorado em nova posição fixa no espaço e rotacionado
                let macbookAnchor = AnchorEntity(world: SIMD3<Float>(-1, -3, 2))
                if let macbook = try? await Entity(named: "MacBook", in: realityKitContentBundle) {
                    macbook.setScale([0.05, 0.05, 0.05], relativeTo: nil)
                    macbook.position = .zero
                    macbook.orientation = simd_quatf(angle: .pi / 1, axis: [0, 1, 0])
                    macbook.components.set(InputTargetComponent())
                    macbook.generateCollisionShapes(recursive: true)
                    macbookAnchor.addChild(macbook)
                    macbookEntity = macbook
                }
                content.add(macbookAnchor)
            }
            .gesture(macbookTapGesture)

            // Botão flutuante (overlay) para abrir a janela com a QuizView
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        openWindow(id: "QuizWindow")
                        // Se preferir fechar o espaço ao abrir a janela 2D, descomente:
                        // Task { await dismissImmersiveSpace() }
                    } label: {
                        Text("Start Quiz")
                            .font(.system(size: 200, weight: .bold))
                            .padding(.horizontal, 80)
                            .padding(.vertical, 40)
                            .frame(minWidth: 500, minHeight: 150)
                            .background(.ultraThinMaterial, in: Capsule())
                            .foregroundStyle(.white)
                            .shadow(radius: 16)
                            .scaleEffect(x: -1, y: 1)
                    }
                    .padding(.trailing, 40)
                    .padding(.bottom, 40)
                }
            }
            .position(x: 200, y: 0)
        }
    }
}
