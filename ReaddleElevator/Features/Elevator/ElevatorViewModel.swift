//
//  ElevatorViewModel.swift
//  ReaddleElevator
//
//  Created by Yevhen Kyivskyi on 19.08.2024.
//

import Foundation
import SwiftUI

@MainActor class ElevatorViewModel: ObservableObject {

    @Published var selectedFloor = 5
    @Published var isPowerOn = true
    
    private var enqueuedFloors: [Int] = []
    private var isAnimating = false
    
//    func seeelectFLoor(_ newFloor: Int) {
//        let item = selectItem(newFloor)
//        
//        item.notify(queue: .main, execute: <#T##DispatchWorkItem#>)
//        
////        let item = DispatchWorkItem {
////            withAnimation(.linear(duration: 1)) { [weak self] in
////                self?.selectedFloor = newFloor
////            }
////        }
////        
////        DispatchQueue.main.async(execute: item)
////        
////        item.notify(queue: .main, execute: )
//        
//    }
//    
//    func selectItem(_ newFloor: Int) -> DispatchWorkItem {
//        DispatchWorkItem {
//            withAnimation(.linear(duration: 1)) { [weak self] in
//                self?.selectedFloor = newFloor
//            }
//        }
//    }
//    
    func selectFloor(_ newFloor: Int) {
        enqueueFloor(newFloor)
    }
}

private extension ElevatorViewModel {
    func enqueueFloor(_ floor: Int) {
        enqueuedFloors.append(floor)
        
        if !isAnimating {
            changeFloor()
        }
    }
    
    func changeFloor() {
        guard let floorToAnimate = enqueuedFloors.first else {
            return
        }
        
        isAnimating = true
        
        withAnimation(.linear(duration: 1)) { [weak self] in
            self?.selectedFloor = floorToAnimate
        } completion: { [weak self] in
            self?.isAnimating = false
            self?.popFloor()
            self?.changeFloor()
        }
    }
    
    func popFloor() {
        if isPowerOn {
            enqueuedFloors.removeFirst()
        } else {
            enqueuedFloors.removeAll()
        }
    }
    
    // TODO: Handle empty array element removing
    func changeFloorWithItems() {
        guard let floorToAnimate = enqueuedFloors.first else {
            return
        }
        
        let item = selectItem(floorToAnimate)
        
        DispatchQueue.main.async(execute: item)
        
        item.notify(queue: .main, execute: item)
    }
    
    func selectItem(_ newFloor: Int) -> DispatchWorkItem {
        DispatchWorkItem {
            withAnimation(.linear(duration: 1)) { [weak self] in
                self?.selectedFloor = newFloor
            } completion: { [weak self] in
                self?.popFloor()
            }
        }
    }
}
