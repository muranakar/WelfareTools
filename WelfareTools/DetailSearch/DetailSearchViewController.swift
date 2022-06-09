//
//  DetailSearchViewController.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/06/02.
//

import UIKit
import MapKit
// 逆ジオコーディングのために、import

class DetailSearchViewController: UIViewController {
    enum TransitionSource {
        case mapVeiwController
        case searchViewController
    }
    @IBOutlet weak private var officeNameLabel: UILabel!
    @IBOutlet weak private var officeTelLabel: UILabel!
    @IBOutlet weak private var officeFaxLabel: UILabel!
    @IBOutlet weak private var officeURLLabel: UILabel!
    @IBOutlet weak private var corporateURLLabel: UILabel!
    @IBOutlet weak private var adressLabel: UILabel!
    @IBOutlet weak private var serviceTypeLabel: UILabel!

    @IBOutlet weak private var officeNameButton: UIButton!
    @IBOutlet weak private var officeTelButton: UIButton!
    @IBOutlet weak private var officeFaxButton: UIButton!
    @IBOutlet weak private var officeURLButton: UIButton!
    @IBOutlet weak private var corporateURLButton: UIButton!
    @IBOutlet weak private var adressButton: UIButton!

    private var transitionSource: TransitionSource
    private var facilityInformation: FacilityInformation
    required init?(coder: NSCoder, facilityInformation: FacilityInformation, transitionSource: TransitionSource) {
        self.transitionSource = transitionSource
        self.facilityInformation = facilityInformation
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        configureButton()
    }
    private func configureLabel() {
        officeNameLabel.text = facilityInformation.officeName
        officeTelLabel.text = facilityInformation.officeTelephoneNumber
        officeFaxLabel.text = facilityInformation.officeFax
        officeURLLabel.text = facilityInformation.officeURL
        corporateURLLabel.text = facilityInformation.corporateURL
        adressLabel.text = facilityInformation.address
        serviceTypeLabel.text = facilityInformation.serviceType
    }

    private func configureButton() {
        officeNameButton.isEnabled = facilityInformation.officeName  != ""
        officeTelButton.isEnabled = facilityInformation.officeTelephoneNumber  != ""
        officeFaxButton.isEnabled = facilityInformation.officeFax  != ""
        officeURLButton.isEnabled = facilityInformation.officeURL  != ""
        corporateURLButton.isEnabled = facilityInformation.corporateURL  != ""
        adressButton.isEnabled = facilityInformation.address  != ""
    }
    @IBAction private func back(_ sender: Any) {
        switch transitionSource {
        case .mapVeiwController:
            performSegue(withIdentifier: "backToMap", sender: nil)
        case .searchViewController:
            performSegue(withIdentifier: "backToSearch", sender: nil)
        }
    }
    @IBAction private func callTelephone(_ sender: Any) {
        let phoneNumber = "\(facilityInformation.officeTelephoneNumber)"
        guard let url = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(url)
    }

    @IBAction private func copyOfficeName(_ sender: Any) {
        copyAndAlert(string: facilityInformation.officeName, message: "事業所名の\nコピーが完了しました。")
    }

    @IBAction private func copyTelNumber(_ sender: Any) {
        copyAndAlert(string: facilityInformation.officeTelephoneNumber, message: "事業所の電話番号の\nコピーが完了しました。")
    }
    @IBAction private func copyFaxNumber(_ sender: Any) {
        copyAndAlert(string: facilityInformation.officeFax, message: "事業所のFAX番号の\nコピーが完了しました。")
    }

    @IBAction private func screenTransitionOfficeURL(_ sender: Any) {
        performSegue(withIdentifier: "webViewOfficeURL", sender: sender)
    }
    @IBAction private func screenTransitionCorporateURL(_ sender: Any) {
        performSegue(withIdentifier: "webViewCorporateURL", sender: sender)
    }
    @IBAction private func searchMapFromAdress(_ sender: Any) {
        let address = "\(facilityInformation.address)"
        var url: URL?
        let encoded =
        "comgooglemaps://?q=\(address)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        url = URL(string: encoded)
        if UIApplication.shared.canOpenURL(url!) {
            // GoogleMapを開く。
            UIApplication.shared.open(url!)
        } else {
            // appleMapを開く。
            let encoded =
            "http://maps.apple.com/?q=\(address)"
                .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            url = URL(string: encoded)
            UIApplication.shared.open(url!)
        }
    }

    private func copyAndAlert(string: String, message: String) {
        UIPasteboard.general.string = string
        // コピーが完了した　とアラート表示
        present(UIAlertController.copyingCompletedFacilityInformation(message: message), animated: true)
    }
}

extension DetailSearchViewController {
    @IBSegueAction
    func makeWebViewOfficeURL(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> WebViewViewController? {
        WebViewViewController(coder: coder, facilityInformation: facilityInformation, showDesignation: .officeURL)
    }
    @IBSegueAction
    func makeWebViewCorparateURL(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> WebViewViewController? {
        WebViewViewController(coder: coder, facilityInformation: facilityInformation, showDesignation: .corporateURL)
    }
    @IBSegueAction
    func makeWebViewMap(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> WebViewViewController? {
        WebViewViewController(coder: coder, facilityInformation: facilityInformation, showDesignation: .mapURL)
    }

    // swiftlint:disable:next private_action
    @IBAction func backToDetailSearchViewController(segue: UIStoryboardSegue) {
    }
}
