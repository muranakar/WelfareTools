//
//  FilterServiceTypeRepository.swift
//  TrainingAndEmploymentServices
//
//  Created by 村中令 on 2022/06/05.
//

import Foundation

struct FilterServiceTypeRepository {
    let key = "filterServiceType"
    func load() -> FilterServiceType? {
        let loadFilterServiceTypeString = UserDefaults.standard.string(forKey: key)
        let allFilterServiceType = FilterServiceType.allCases
        guard let filteredFilterServiceType =
                allFilterServiceType.filter({ $0.string == loadFilterServiceTypeString }).first else {
            return nil
        }
        return filteredFilterServiceType
    }
    func save(filterServiceType: FilterServiceType) {
        UserDefaults.standard.set(filterServiceType.string, forKey: key)
    }
}
