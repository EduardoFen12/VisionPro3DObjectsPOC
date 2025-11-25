//
//  ContentView.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 17/10/25.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct ContentView: View {
    
    @State private var modeloAtual: String = "Car"
    
    // Nomes devem CORRESPONDER exatamente aos nomes dos assets no RealityKitContent (sem a extensão .usdz)
    let modelosDisponiveis = ["Sphere", "DinoBones", "Car", "Katana", "Canon"]
    
    var body: some View {
        VStack {
            // CARREGAMENTO DO MODELO 3D:
            // named: usa o nome do asset (ex: "Sphere")
            // bundle: aponta para o pacote onde os assets estão armazenados (RealityKitContent)
            Model3D(named: modeloAtual, bundle: realityKitContentBundle) { modelo in
                
                modelo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(depth: 500)
                    .scaleEffect(0.5) // Adicionado um scale para garantir que modelos grandes caibam
                    .rotation3DEffect(
                        .degrees(45), axis: (x: 0, y: 1, z: 0)
                    )
                    .offset(z: -2)
                    
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
            
            // PAINEL DE BOTÕES 2D
            HStack {
                
                ForEach(modelosDisponiveis, id: \.self) { nomeModelo in
                    Button(nomeModelo) {
                        modeloAtual = nomeModelo
                    }
                    .padding()
                }
                
            }
            .glassBackgroundEffect()
        }
        .padding()
        .frame(width: 800, height: 600)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
