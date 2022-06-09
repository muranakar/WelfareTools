//
//  TrainingAndEmploymentServicesTests.swift
//  TrainingAndEmploymentServicesTests
//
//  Created by 村中令 on 2022/06/05.
//

import XCTest
@testable import TrainingAndEmploymentServices

class UseCaseCsvConversionTests: XCTestCase {

    func testExample() throws {
      let facilityInformations =
        UseCaseFilterFacilityInformation.filterFacilityInformationFromDataBase(filterServiceType: .homestayTypeSelfRelianceTraining)
        XCTAssertEqual(facilityInformations[1].corporateName, "社会福祉法人　緑伸会")
        XCTAssertEqual(facilityInformations[1].address, "北海道札幌市中央区南２２条西９丁目１番３７号")
        XCTAssertEqual(facilityInformations[1].latitude, "43.03071238")
//        "01100","A0000041524","札幌市","社会福祉法人　緑伸会","しゃかいふくしほうじんりょくしんかい","2430005013423","北海道札幌市中央区","札幌市中央区大通西１０丁目４番地ダンロップSKビル","011-261-1313","011-251-3132","https://ryoku-sin.or.jp/","宿泊型自立訓練","ぴあ山鼻","ぴあやまはな","0110103645","北海道札幌市中央区","南２２条西９丁目１番３７号","011-206-4984","011-206-4985","https://ryoku-sin.or.jp/",43.03071238,141.34788120,"","","","",,,10

        let workforceRehabilitationSupportTypeBFacilityInformations =
        UseCaseFilterFacilityInformation.filterFacilityInformationFromDataBase(filterServiceType: .workforceRehabilitationSupportTypeB)
          XCTAssertEqual(
            workforceRehabilitationSupportTypeBFacilityInformations[1].corporateName,
            "株式会社　キャリアエディション"
          )
          XCTAssertEqual(
            workforceRehabilitationSupportTypeBFacilityInformations[1].address,
            "北海道札幌市中央区大通西１丁目１３番地ル・トロワ８階"
          )
          XCTAssertEqual(
            workforceRehabilitationSupportTypeBFacilityInformations[1].latitude,
            "43.06023161"
          )

        //"01100","A0000013746","札幌市","株式会社　キャリアエディション","かぶしきがいしゃきゃりあえでぃしょん","9430001076731","北海道札幌市中央区","北４条西６丁目１番地毎日札幌会館４階","011-522-8753","011-522-8769","http://career-edition.info/","就労継続支援Ｂ型","キャリアエディション","きゃりあえでぃしょん","0110103470","北海道札幌市中央区","大通西１丁目１３番地ル・トロワ８階","011-215-0440","011-215-0441","https://career-edition.info/",43.06023161,141.35587326,"10:00-18:00","10:00-18:00","10:00-18:00","10:00-18:00","年末年始",,20
    }


}
