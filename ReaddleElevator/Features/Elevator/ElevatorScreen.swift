//
//  ElevatorScreen.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import SwiftUI

struct ElevatorScreen: View {
    
    @StateObject var viewModel = ElevatorViewModel()
    
    var body: some View {
        List {
            ForEach(1...9, id:\.self) { floor in
                HStack {
                    if floor == viewModel.selectedFloor {
                        currentFloorView(floor)
                    } else {
                        floorView(floor)
                    }
                }
                .frame(maxHeight: 40)
            }
            ControlPowerUnitView(
                currentFloor: viewModel.selectedFloor,
                isPowerOn: $viewModel.isPowerOn
            )
        }
    }
}

private extension ElevatorScreen {
    func floorView(_ floor: Int) -> some View {
        FloorView(
            floorNumber: floor,
            isSelectedFloor: floor == viewModel.selectedFloor,
            isPowerOn: viewModel.isPowerOn,
            elevatorCalledAction: viewModel.selectFloor(_:)
        )
    }
    
    func currentFloorView(_ floor: Int) -> some View {
        FloorView(
            floorNumber: floor,
            isSelectedFloor: floor == viewModel.selectedFloor,
            isPowerOn: viewModel.isPowerOn,
            elevatorCalledAction: viewModel.selectFloor(_:),
            elevatorViewBuilder: {
                ElevatorView(
                    maxFloor: 9,
                    selectedFloor: viewModel.selectedFloor,
                    isPowerOn: viewModel.isPowerOn,
                    floorPressedAction: viewModel.selectFloor(_:)
                )
            }
        )
    }
}

#Preview {
    ElevatorScreen()
}
