//
//  PasteboardFormatterFacilityInformation.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/17.
//

import Foundation

final class PasteboardFormatterFacilityInformation {
    func string(from facilityInformation: FacilityInformation) -> String {
        return """
        事業所情報
        事業所名:
        \(facilityInformation.officeName)
        事業所名（かな）:
        \(facilityInformation.officeNameKana)
        事業所住所:
        \(facilityInformation.address)
        事業所電話番号:
        \(facilityInformation.officeTelephoneNumber)
        事業所FAX:
        \(facilityInformation.officeFax)
        事業所ホームページ:
        \(facilityInformation.officeURL)
        会社名:
        \(facilityInformation.corporateName)
        会社名（かな）:
        \(facilityInformation.corporateKana)
        会社電話番号:
        \(facilityInformation.corporateTelephoneNumber)
        会社FAX:
        \(facilityInformation.corporateFax)
        会社ホームページ:
        \(facilityInformation.corporateURL)
        """
    }
}
