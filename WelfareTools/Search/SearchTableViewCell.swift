//
//  SearchTableViewCell.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/30.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak private var firstTitleLabel: UILabel!
    @IBOutlet weak private var firstDetailInformationLabel: UILabel!
    @IBOutlet weak private var secondTitleLabel: UILabel!
    @IBOutlet weak private var secondDetailInformationLabel: UILabel!
    @IBOutlet weak private var mapAttentionLabel: UILabel!
    func configure(
        firstTitle: String,
        firstInformation: String,
        secondTitle: String,
        secondInformation: String,
        isHiddenMapAttention: Bool
    ) {
        firstTitleLabel.text = firstTitle
        firstDetailInformationLabel.text = firstInformation
        secondTitleLabel.text = secondTitle
        secondDetailInformationLabel.text = secondInformation
        mapAttentionLabel.isHidden = isHiddenMapAttention
    }
}
