//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol,
         storageManager: StorageManagerProtocol,
         networkManager: NetworkManagerProtocol)
    func generateRocket(with model: RocketModel)
    func updateFeature()
    func getImage(from url: String)
    /// Adaptive table height calculation
    func calculateHeightTable(data: [SectionMainTable]) -> CGFloat
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    let network: NetworkManagerProtocol!
    private var features: [RocketFeature] = []
    
    // MARK: - Init
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        storage = storageManager
        network = networkManager
    }
    
    // MARK: - MainPresenterProtocol Impl
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
        else {
            view.failureLoadSettings()
            return
        }
        
        for (index, feature) in features.enumerated() {
            if let setting = settings.first(where: { $0.type == feature.type }) {
                features[index].selectedIndex = setting.selectedIndex
            }
        }
        
        view.update(feature: features)
    }
    
    func getImage(from url: String) {
        network.downloadImage(from: url) { [weak self] image in
            guard let self, let image else { return }
            self.view.setImage(image)
        }
    }
    
    func calculateHeightTable(data: [SectionMainTable]) -> CGFloat {
        var height: CGFloat = 0
        for section in data {
            
            switch section.type {
            case .launchButton:
                section.cells.forEach { _ in height += MainTableConstants.cellButtonHeight }
            default:
                section.cells.forEach { _ in height += MainTableConstants.cellHeight }
            }
            
            switch section.type {
            case .firstStage, .secondStage:
                height += MainTableConstants.sectionHeaderStageHeight
            default:
                height += MainTableConstants.sectionHeaderDefaultHeight
            }
            
            switch section.type {
            case .info, .firstStage:
                height += MainTableConstants.sectionFooterBeginnersStageHeight
            case .secondStage, .launchButton:
                height += MainTableConstants.sectionFooterFinalsStageHeight
            }
        }
        return height
    }
}

// MARK: - Private ext
private extension MainPresenter {
    
    func generateFeatures(with model: RocketModel) {
        guard let settings: [Setting] = storage.decodableData(forKey: .settings) else {
            view.failureLoadSettings()
            return
        }
        
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
