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
    var rocket: Rocket?
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func getDataRockets(numbRocket: Int) {
        guard let data: [RocketModel] = storage.decodableData(forKey: .rockets) else {
            view.failure()
            return
        }
        
        let actRocket = data[numbRocket - 1]
        
        rocket = Rocket(id: actRocket.id,
                        images: actRocket.flickrImages,
                        name: actRocket.name,
                        features: [Feature(type: .length(meters: actRocket.height.meters!,
                                                         feet: actRocket.height.feet!), name: "Высота")],
                        firstFlight: actRocket.firstFlight,
                        country: actRocket.country,
                        costPerLaunch: actRocket.costPerLaunch,
                        firstStage: .init(engines: actRocket.firstStage.engines,
                                          fuelAmountTons: actRocket.firstStage.fuelAmountTons,
                                          burnTimeSec: actRocket.firstStage.burnTimeSec),
                        secondStage: .init(engines: actRocket.secondStage.engines,
                                           fuelAmountTons: actRocket.secondStage.fuelAmountTons,
                                           burnTimeSec: actRocket.secondStage.burnTimeSec))
        
        view.success(rocket: rocket!)
    }
}
