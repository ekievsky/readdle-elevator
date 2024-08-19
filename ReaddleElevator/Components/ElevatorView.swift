//
//  ElevatorView.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import SwiftUI

struct ElevatorView: View {
    
    private let maxFloor: Int
    private let selectedFloor: Int
    private let isPowerOn: Bool
    private let floorPressedAction: (Int) -> ()
    
    var body: some View {
        HStack {
            ForEach(1...maxFloor, id: \.self) { floor in
                Button(
                    action: {
                        floorPressedAction(floor)
                    },
                    label: {
                        Text("\(floor)")
                            .foregroundStyle(isPowerOn ? activeColor(for: floor) : Color.gray)
                    }
                )
                .buttonStyle(.borderless)
                .disabled(!isPowerOn)
            }
        }
    }
    
    init(
        maxFloor: Int,
        selectedFloor: Int,
        isPowerOn: Bool,
        floorPressedAction: @escaping (Int) -> Void
    ) {
        self.maxFloor = maxFloor
        self.selectedFloor = selectedFloor
        self.isPowerOn = isPowerOn
        self.floorPressedAction = floorPressedAction
    }
}

private extension ElevatorView {
    
    func activeColor(for floor: Int) -> Color {
        floor == selectedFloor ? Color.blue : Color.black
    }
}

#Preview {
    ElevatorView(maxFloor: 9, selectedFloor: 3, isPowerOn: true) { _ in }
}
