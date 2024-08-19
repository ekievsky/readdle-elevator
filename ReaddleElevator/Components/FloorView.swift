//
//  FloorView.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import SwiftUI

struct FloorView<Elevator: View>: View {
    
    private let elevatorViewBuilder: () -> Elevator
    private let elevatorCalledAction: (Int) -> ()
    
    private let isPowerOn: Bool
    private let floorNumber: Int
    private let isSelectedFloor: Bool
    
    var activeColor: Color {
        isSelectedFloor ? Color.blue : Color.black
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("\(floorNumber)")
                FloorPanelView {
                    elevatorCalledAction(floorNumber)
                }
            }
            elevatorViewBuilder()
            Spacer()
        }
        .foregroundStyle(isPowerOn ? activeColor : Color.gray)
        .disabled(!isPowerOn)
    }
    
    init(
        floorNumber: Int,
        isSelectedFloor: Bool,
        isPowerOn: Bool,
        elevatorCalledAction: @escaping (Int) -> (),
        elevatorViewBuilder: @escaping () -> Elevator
    ) {
        self.floorNumber = floorNumber
        self.isSelectedFloor = isSelectedFloor
        self.isPowerOn = isPowerOn
        self.elevatorCalledAction = elevatorCalledAction
        self.elevatorViewBuilder = elevatorViewBuilder
    }
    
    init(
        floorNumber: Int,
        isSelectedFloor: Bool,
        isPowerOn: Bool,
        elevatorCalledAction: @escaping (Int) -> ()
    ) where Elevator == EmptyView {
        self.init(
            floorNumber: floorNumber,
            isSelectedFloor: isSelectedFloor,
            isPowerOn: isPowerOn,
            elevatorCalledAction: elevatorCalledAction,
            elevatorViewBuilder: { EmptyView()}
        )
    }
}

#Preview {
    FloorView(floorNumber: 1, isSelectedFloor: false, isPowerOn: false) {_ in}
}
