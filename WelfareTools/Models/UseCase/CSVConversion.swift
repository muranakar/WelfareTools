//
//  CSVConversion.swift
//  TrainingAndEmploymentServices
//
//  Created by 村中令 on 2022/06/05.
//

import Foundation
import SwiftUI

struct CsvConversion {
    static func convertFacilityInformationFromCsv (serviceType: ServiceType) -> [FacilityInformation] {
        var csvLineOneDimensional: [String] = []
        var csvLineTwoDimensional: [[String]] = []
        var pediatricWelfareServices: [FacilityInformation] = []
        guard let path = Bundle.main.path(
            forResource: "\(serviceType.fileName)",
            ofType: "csv"
        ) else {
            print("csvファイルがないよ")
            return []
        }
        let csvString = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        csvLineOneDimensional = csvString.components(separatedBy: "\r\n")
        // 一次元配列のString型を、二次元配列のString型へ変換
        csvLineOneDimensional.forEach { string in
            var array: [String] = []
            array = string.components(separatedBy: ",")
            let revisionArray = array.map { string -> String in
                let revisonString = string.replacingOccurrences(of: "\"", with: "")
                return revisonString
            }
            guard array.count == 24 else {
print( array)
                return
            }
            csvLineTwoDimensional.append(revisionArray)
        }
        
        // 二次元配列のString型を、共通型に変換
        csvLineTwoDimensional.forEach { array in
            let pediatricWelfareService = FacilityInformation(
                serviceType: array[6],
                corporateName: array[14],
                // TODO: 値がない場合はどのようにするか？
                corporateKana: "",
                corporateURL: array[19],
                corporateTelephoneNumber: array[11],
                corporateFax: array[12],
                officeName: array[4],
                officeNameKana: array[5],
                officeURL: array[19],
                officeTelephoneNumber: array[11],
                officeFax: array[12],
                address: array[7],
                latitude: array[9],
                longitude: array[10])
            pediatricWelfareServices.append(pediatricWelfareService)
        }
        return pediatricWelfareServices
    }
}

enum ServiceType: CaseIterable {
    case shortStay
    case shortStayHealthCareFacilityfortheElderly
    case shortStayLongTermCareMedicalFacilities
    case shortStayLongTermCareMedicalFacility
}

extension ServiceType {
    var stringJapanese: String {
        switch self {
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
    
    var fileName: String {
        switch self {
        case .shortStay:
            return "210_短期入所生活介護"
        case .shortStayHealthCareFacilityfortheElderly:
            return "220_短期入所療養介護（介護老人保健施設）"
        case .shortStayLongTermCareMedicalFacilities:
            return "230_短期入所療養介護（介護療養型医療施設）"
        case .shortStayLongTermCareMedicalFacility:
            return "551_短期入所療養介護（介護医療院）"
        }
    }
}
