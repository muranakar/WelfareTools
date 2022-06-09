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
        case .shortStay:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .shortStay
            )
        case .shortStayHealthCareFacilityfortheElderly:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .shortStayHealthCareFacilityfortheElderly
            )
        case .shortStayLongTermCareMedicalFacilities:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .shortStayLongTermCareMedicalFacilities
            )
        case .shortStayLongTermCareMedicalFacility:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .shortStayLongTermCareMedicalFacility
            )
        }
        return facilityInformations
    }
}
