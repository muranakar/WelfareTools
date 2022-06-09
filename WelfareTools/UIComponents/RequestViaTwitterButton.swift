//
//  RequestViaTwitterButton.swift
//  TimerAssessment
//
//  Created by Takehito Koshimizu on 2022/02/13.
//

import UIKit

@IBDesignable
class RequestViaTwitterButton: UIButton {
    private let title = "修正依頼"
    private let subtitle = "(Twitter)"

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
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        backgroundColor = .white
        configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.title = title
            configuration.subtitle = subtitle
            configuration.image = {
                let symbolConfiguration = UIImage.SymbolConfiguration(scale: .large)
                return UIImage(systemName: "envelope", withConfiguration: symbolConfiguration)
            }()
            configuration.background = .listPlainCell()
            configuration.baseBackgroundColor = .purple
            return configuration
        }()
    }

    private func updateLayer() {
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
        layer.shadowColor = Colors.mainColor.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 130, height: 60)
    }
}

#if canImport(SwiftUI)
import SwiftUI

struct RequestViaTwitterButton_Previews: PreviewProvider {
    struct Representable: UIViewRepresentable {
        func makeUIView(context: Context) -> RequestViaTwitterButton {
            RequestViaTwitterButton()
        }

        func updateUIView(_: RequestViaTwitterButton, context: Context) {
        }
    }

    static var previews: some View {
        Representable()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 8")
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.fixed(width: 130, height: 60))
    }
}
#endif
