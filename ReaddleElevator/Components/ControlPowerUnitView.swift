//
//  ControlPowerUnitView.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import SwiftUI

struct ControlPowerUnitView: View {
    
    private let currentFloor: Int
    
    @Binding private var isPowerOn: Bool

    var body: some View {
        HStack {
            Button(
                action: {
                    isPowerOn.toggle()
                },
                label: {
                    if isPowerOn {
                        Image(systemName: "lightswitch.on")
                    } else {
                        Image(systemName: "lightswitch.off")
                    }
                }
            )
            .foregroundStyle(isPowerOn ? Color.green : Color.red)
            .buttonStyle(.borderless)
            Text("Current floor: \(currentFloor)")
        }
    }
    
    init(currentFloor: Int, isPowerOn: Binding<Bool>) {
        self.currentFloor = currentFloor
        self._isPowerOn = isPowerOn
    }
}

#Preview {
    ControlPowerUnitView(currentFloor: 1, isPowerOn: .constant(false))
}
