//
//  CurrentLocationButton.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/17.
//
import UIKit

@IBDesignable
class CurrentLocationButton: UIButton {
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
        backgroundColor = .white
    }

    private func updateLayer() {
        layer.cornerRadius = 10
        layer.borderColor =  Colors.mainColor.cgColor
        layer.borderWidth = 2
    }
}
