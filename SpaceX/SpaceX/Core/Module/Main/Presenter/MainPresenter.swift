//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol)
    func getDataRockets(numbRocket: Int)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func getDataRockets(numbRocket: Int) {
        if let data: [RocketModel] = storage.decodableData(forKey: .rockets) {
            let rocketData = data[numbRocket - 1]
                        
//            let rocket = Rocket(id: rocketData.id,
//                                image: UIImage(systemName: "circle"),
//                                name: rocketData.name,
//                                height: RocketData.Parameter(value: "", unit: ""),
//                                diameter: RocketData.Parameter(value: "", unit: ""),
//                                mass: RocketData.Parameter(value: "", unit: ""),
//                                payloadWeight: RocketData.Parameter(value: "", unit: ""),
//                                firstFlight: "",
//                                country: "",
//                                costPerLaunch: 0,
//                                firstStage: RocketData.Stage(engines: 0,
//                                                             fuelAmountTons: 0,
//                                                             burnTimeSec: 0),
//                                secondStage: RocketData.Stage(engines: 0,
//                                                              fuelAmountTons: 0,
//                                                              burnTimeSec: 0))
            
        }
    }
}
