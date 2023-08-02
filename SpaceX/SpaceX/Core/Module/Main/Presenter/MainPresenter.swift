//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol)
    func generateRocket(with model: RocketModel)
    func updateFeature()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    private var features: [RocketFeature] = []
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func generateRocket(with model: RocketModel) {
        generateFeatures(with: model)
        
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
        view.configure(rocket: rocket)
    }
    
    func updateFeature() {
        guard let settings: [Setting] = storage.decodableData(forKey: .settings),
                  !features.isEmpty
        else { return }
        
        for (index, feature) in features.enumerated() {
            if let setting = settings.first(where: { $0.type == feature.type }) {
                features[index].selectedIndex = setting.selectedIndex
            }
        }
        
        view.update(feature: features)
    }
}

private extension MainPresenter {
    
    func generateFeatures(with model: RocketModel) {
        guard let settings: [Setting] = storage.decodableData(forKey: .settings) else { return }
        
        settings.forEach { setting in
            switch setting.type {
                
            case .height:
                guard let meters = model.height.meters,
                      let feets = model.height.feet else { return }
                let feature = RocketFeature(unit: (eu: meters, us: feets),
                                            type: .height,
                                            selectedIndex: setting.selectedIndex)
                features.append(feature)
                
            case .diameter:
                guard let meters = model.diameter.meters,
                      let feets = model.diameter.feet else { return }
                let feature = RocketFeature(unit: (eu: meters, us: feets),
                                            type: .diameter,
                                            selectedIndex: setting.selectedIndex)
                features.append(feature)
                
            case .weight:
                let kg = model.mass.kg, lb = model.mass.lb
                let feature = RocketFeature(unit: (eu: Double(kg), us: Double(lb)),
                                            type: .weight,
                                            selectedIndex: setting.selectedIndex)
                features.append(feature)
                
            case .payload:
                guard let kg = model.payloadWeights.first?.kg,
                      let lb = model.payloadWeights.first?.lb else { return }
                let feature = RocketFeature(unit: (eu: Double(kg), us: Double(lb)),
                                            type: .payload,
                                            selectedIndex: setting.selectedIndex)
                features.append(feature)
            }
        }
    }
}
