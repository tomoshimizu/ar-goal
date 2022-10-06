//
//  ARViewContainer.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/30.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {

    let vm: ViewModel

    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator,
                                                           action: #selector(Coordinator.tapped)))
        
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        vm.onSave = {
            context.coordinator.saveWorldMap()
        }
        vm.onClear = {
            context.coordinator.clearWorldMap()
        }
        context.coordinator.loadWorldMap()

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
}
