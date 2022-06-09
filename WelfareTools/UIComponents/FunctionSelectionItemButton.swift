//
//  FunctionSelectionItemButton.swift
//  TimerAssessment
//
//  Created by Takehito Koshimizu on 2022/02/17.
//

import UIKit

@IBDesignable
class FunctionSelectionItemButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeContent()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeContent()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayer()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeContent()
    }

    private func initializeContent() {
    }

    private func updateLayer() {
        layer.cornerRadius = 10
        layer.borderColor =  Colors.mainColor.cgColor
        layer.borderWidth = 2
    }
}
