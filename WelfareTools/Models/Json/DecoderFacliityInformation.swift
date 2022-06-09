//
//  DecoderFacilityInformation.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/13.
//

import Foundation

struct DecoderFacilityInformation {
    static func loadDecodableFacilityInformation() -> [DecodableFacilityInformation] {
        /// ①プロジェクト内にあるファイルのパス取得
        guard let url = Bundle.main.url(forResource: "ChildDevelopmentSupport", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
        /// ②Data型プロパティに読み込み
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        /// ③JSONデコード処理
        let decoder = JSONDecoder()
        guard let decoderFacilityInformations =
                try? decoder.decode([DecodableFacilityInformation].self, from: data) else {
            fatalError("JSON読み込みエラー")
        }

        //        let facilityInformations = decoderFacilityInformations.map { FacilityInformation(decoder: $0)}

        return decoderFacilityInformations
    }

    static func loadFacilityInformation() -> [FacilityInformation] {
        /// ①プロジェクト内にあるファイルのパス取得
        guard let url = Bundle.main.url(forResource: "ChildDevelopmentSupport", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
        /// ②Data型プロパティに読み込み
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        /// ③JSONデコード処理
        let decoder = JSONDecoder()
        guard let decoderFacilityInformations =
                try? decoder.decode([DecodableFacilityInformation].self, from: data) else {
            fatalError("JSON読み込みエラー")
        }

        let facilityInformations = decoderFacilityInformations.map { FacilityInformation(decoder: $0)}

        return facilityInformations
    }
}

struct DecodableFacilityInformation: Decodable {
    let serviceType: String
    let corporateName: String
    let corporateKana: String
    let corporateURL: String
    let corporateTelephoneNumber: String
    let corporateFax: String
    let officeName: String
    let officeNameKana: String
    let officeURL: String
    let officeTelephoneNumber: String
    let officeFax: String
    let addressCity: String
    let addressNumber: String
    let latitude: String
    let longitude: String

    private enum CodingKeys: String, CodingKey {
        case serviceType = "Service_Type"
        case corporateName = "Name_of_corporation"
        case corporateKana = "Corporate_name_Kana"
        case corporateURL = "Corporation_URL"
        case corporateTelephoneNumber = "Corporate_telephone_number"
        case corporateFax = "Corporate_Fax_No."
        case officeName = "Name_of_office"
        case officeNameKana = "Name_of_business_office_Kana"
        case officeURL = "Office_URL"
        case officeTelephoneNumber = "Office_phone_number"
        case officeFax = "Office_fax_number"
        case addressCity = "Office_Address_City"
        case addressNumber = "Business_Address_Number"
        case latitude = "Office_latitude"
        case longitude = "Office_longitude"
    }
}

private extension FacilityInformation {
    init(decoder: DecodableFacilityInformation) {
        serviceType = decoder.serviceType
        corporateName = decoder.corporateName
        corporateKana = decoder.corporateKana
        corporateURL = decoder.corporateURL
        corporateTelephoneNumber = decoder.corporateTelephoneNumber
        corporateFax = decoder.corporateFax
        officeName = decoder.officeName
        officeNameKana = decoder.officeNameKana
        officeURL = decoder.officeURL
        officeTelephoneNumber = decoder.officeTelephoneNumber
        officeFax = decoder.officeFax
        address = decoder.addressCity + decoder.addressNumber
        latitude = decoder.latitude
        longitude = decoder.longitude
    }
}
