//
//  ReviewRepository.swift
//  LineConnectingGame
//
//  Created by 村中令 on 2022/06/22.
//

import Foundation

struct ReviewRepository {
    static func processAfterAddReviewNumPulsOneAndSaveReviewNum() -> Int {
        let key = "review"
        var loadAd = UserDefaults.standard.integer(forKey: key)
        loadAd += 1
        UserDefaults.standard.set(loadAd, forKey: key)
        return loadAd
    }
}
