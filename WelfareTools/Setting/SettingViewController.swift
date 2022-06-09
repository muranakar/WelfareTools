//
//  SettingViewController.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/12.
//

import UIKit
import GoogleMobileAds

class SettingViewController: UIViewController {
    let pickerViewItemsOfFilterServiceType = FilterServiceType.allCases
    let filterServiceTypeRepository = FilterServiceTypeRepository()

    @IBOutlet weak private var filterServiceTypePickerView: UIPickerView!
    @IBOutlet weak private var bannerView: GADBannerView!
    // 追加したUIViewを接続
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdBannar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectRowFilterServiceTypePickerView()
    }

    @IBAction private func configureCoreLocation(_ sender: Any) {
        configureLocationInformation()
    }

    @IBAction private func jumpToTwitter(_ sender: Any) {
        jumpToTwitterInformation()
    }

    private func selectRowFilterServiceTypePickerView() {
        guard let loadedFilterServiceType = filterServiceTypeRepository.load() else { return }
        let filterServiceTypeRow = pickerViewItemsOfFilterServiceType.firstIndex(of: loadedFilterServiceType)
        guard let filterServiceTypeRow = filterServiceTypeRow else { return }
        filterServiceTypePickerView.selectRow(filterServiceTypeRow, inComponent: 0, animated: true)
    }

    private func configureLocationInformation() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

    private func jumpToTwitterInformation() {
        let url = NSURL(string: "https://twitter.com/iOS76923384")
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    private func configureAdBannar() {
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = "\(GoogleAdID.bannerID)"
        bannerView.rootViewController = self

        // 広告読み込み
        bannerView.load(GADRequest())
    }
}

extension SettingViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.text = pickerViewItemsOfFilterServiceType[row].string
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerViewItemsOfFilterServiceType[row].string
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let filterServiceType =
        FilterServiceType.allCases.filter { $0.string == pickerViewItemsOfFilterServiceType[row].string }.first!
        filterServiceTypeRepository.save(filterServiceType: filterServiceType)
    }
}

extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewItemsOfFilterServiceType.count
    }
}
