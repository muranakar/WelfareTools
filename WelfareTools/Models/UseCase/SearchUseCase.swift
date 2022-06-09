//
//  SearchUseCase.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/30.
//

import Foundation

struct UseCaseSearch {
    static func filteredSearchFacilityInformation(
        filterServiceType: FilterServiceType,
        filterSearch: FilterSearch,
        string: String
    ) -> [FacilityInformation] {
        let allFacilityInformation =
        UseCaseFilterFacilityInformation.filterFacilityInformationFromDataBase(filterServiceType: filterServiceType)
        var filterFacilityInformation: [FacilityInformation]
        switch filterSearch {
        case .officeNameAndOfficeNameKana:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.officeName.contains(string) || $0.officeNameKana.contains(string) }
        case .corporateNameAndCoporateKana:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.corporateName.contains(string) || $0.corporateKana.contains(string) }
        case .address:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.address.contains(string) }
        }
        return filterFacilityInformation
    }
}

enum FilterServiceType: CaseIterable {
    case all
    case welfareEquipmentRental
    case specifiedWelfareEquipment
}
extension FilterServiceType {
    var string: String {
        switch self {
        case .all:
            return "全てのサービス"
        case .welfareEquipmentRental:
            return "福祉用具貸与"
        case .specifiedWelfareEquipment:
            return "特定福祉用具販売"
        }
    }
}

enum FilterSearch {
    init(string: String) {
        switch string {
        case "事業所名":
            self = .officeNameAndOfficeNameKana
        case "会社名":
            self = .corporateNameAndCoporateKana
        case "住所":
            self = .address
        default:
            fatalError("FilterSearchに値が設定されていません。")
        }
    }
    case officeNameAndOfficeNameKana
    case corporateNameAndCoporateKana
    case address
}
