//
//  UIAlertController.swift
//  TimerAssessment
//
//  Created by Ryo Muranaka on 2022/02/20.
//

import UIKit

extension UIAlertController {
    /// 事業所情報のコピーが完了しました。
    static func copyingCompletedFacilityInformation(message: String) -> Self {
        let title = "コピー完了"
        let message = "\(message)"
        let controller = self.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return controller
    }
    /// ピンが選択されていません。
    static func checkIsSelectedAnnotation() -> Self {
        let title = "ピンの未選択"
        let message = "ピンを選択してから\nボタンを押してください。"
        let controller = self.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return controller
    }

    static func configureLocationSetting(okHandler:@escaping () -> Void) -> Self {
        let title = "現在地の取得不可"
        let message = "現在地が取得できません。\n設定を行いますか？"
        let alertController = self.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "設定する",
            style: .cancel) { _ in
                okHandler()
            }
        let cancelAction = UIAlertAction(title: "設定しない", style: .default)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
