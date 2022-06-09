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
    case shortStay
    case shortStayHealthCareFacilityfortheElderly
    case shortStayLongTermCareMedicalFacilities
    case shortStayLongTermCareMedicalFacility
}
extension FilterServiceType {
    var string: String {
        switch self {
        case .all:
            return "全てのサービス"
        case .shortStay:
            return "短期入所生活介護"
        case .shortStayHealthCareFacilityfortheElderly:
            return "短期入所療養介護（介護老人保健施設）"
        case .shortStayLongTermCareMedicalFacilities:
            return "短期入所療養介護（介護療養型医療施設）"
        case .shortStayLongTermCareMedicalFacility:
            return "短期入所療養介護（介護医療院）"
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
