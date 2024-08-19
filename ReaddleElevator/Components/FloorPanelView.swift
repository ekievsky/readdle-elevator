//
//  FloorPanelView.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import SwiftUI

struct FloorPanelView: View {
    
    private let callElevatorAction: () -> ()
    
    var body: some View {
        Button(action: callElevatorAction) {
            Image(systemName: "arrow.up.and.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
        .buttonStyle(.borderless)
    }
    
    init(callElevatorAction: @escaping () -> Void) {
        self.callElevatorAction = callElevatorAction
    }
}

#Preview {
    FloorPanelView {}
}
