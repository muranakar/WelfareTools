//
//  UserDefaults.swift
//  CoreLocationSample
//
//  Created by 村中令 on 2022/05/08.
//

import Foundation

struct PrefectureRepository {
    let key = "prefecture"
    func load() -> JapanesePrefecture? {
        let loadPrefectureString = UserDefaults.standard.string(forKey: key)
        let prefectures = JapanesePrefecture.all
        guard let filteredPrefecture = prefectures.filter({ $0.nameWithSuffix == loadPrefectureString }).first else {
            return nil
        }
        return filteredPrefecture
    }
    func save(prefecture: JapanesePrefecture) {
        UserDefaults.standard.set(prefecture.nameWithSuffix, forKey: key)
    }
}
