//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol)
    func getRocket(with model: RocketModel)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func getRocket(with model: RocketModel) {
        let rocket = Rocket(id: model.id,
                        images: model.flickrImages,
                        name: model.name,
                        features: [Feature(type: .length(meters: model.height.meters!,
                                                         feet: model.height.feet!), name: "Высота")],
                        firstFlight: model.firstFlight,
                        country: model.country,
                        costPerLaunch: model.costPerLaunch,
                        firstStage: .init(engines: model.firstStage.engines,
                                          fuelAmountTons: model.firstStage.fuelAmountTons,
                                          burnTimeSec: model.firstStage.burnTimeSec),
                        secondStage: .init(engines: model.secondStage.engines,
                                           fuelAmountTons: model.secondStage.fuelAmountTons,
                                           burnTimeSec: model.secondStage.burnTimeSec))
        
        view.success(rocket: rocket)
    }
}
