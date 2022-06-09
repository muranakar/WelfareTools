//
//  CSVConversion.swift
//  CoreLocationSample
//
//  Created by 村中令 on 2022/05/05.
//

import Foundation

struct UseCaseFilterFacilityInformation {
    static func filterFacilityInformationFromDataBase(filterServiceType: FilterServiceType) -> [FacilityInformation] {
        var facilityInformations: [FacilityInformation] = []
        switch filterServiceType {
        case .all:
            let allServiceType = ServiceType.allCases
            allServiceType.forEach { serviceType in
                let array = CsvConversion.convertFacilityInformationFromCsv(serviceType: serviceType)
                facilityInformations += array
            }
        case .welfareEquipmentRental:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .welfareEquipmentRental
            )
        case .specifiedWelfareEquipment:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedWelfareEquipment
            )
        }
        return facilityInformations
    }
}
