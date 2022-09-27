//
//  ARViewContainer.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/15.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {

    @ObservedObject var vm: ViewModel
        
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero,
                            cameraMode: .ar,
                            automaticallyConfigureSession: true)
        
        arView.addTapGesture()

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
