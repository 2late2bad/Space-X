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
    func updateFeature()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    private var rocketModel: RocketModel?
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func getRocket(with model: RocketModel) {
        rocketModel = model
        let rocket = Rocket(id: model.id,
                        images: model.flickrImages,
                        name: model.name,
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
    
    func updateFeature() {
        guard let model = rocketModel,
              let settings: [Setting] = storage.decodableData(forKey: .settings)
        else { return }
        
        var rocketFeatures: [Feature] = []
        settings.forEach { setting in
            switch setting.type {
            case .height:
                let feature = Feature(values: (eu: model.height.meters!,
                                                  us: model.height.feet!),
                                         setting: setting)
                rocketFeatures.append(feature)
            case .diameter:
                let feature = Feature(values: (eu: model.diameter.meters!,
                                                  us: model.diameter.feet!),
                                         setting: setting)
                rocketFeatures.append(feature)
            case .weight:
                let feature = Feature(values: (eu: Double(model.mass.kg),
                                                  us: Double(model.mass.lb)),
                                         setting: setting)
                rocketFeatures.append(feature)
            case .payload:
                let feature = Feature(values: (eu: Double(model.payloadWeights[0].kg),
                                                  us: Double(model.payloadWeights[0].lb)),
                                         setting: setting)
                rocketFeatures.append(feature)
            }
        }
        
        view.success(feature: rocketFeatures)
    }
}
