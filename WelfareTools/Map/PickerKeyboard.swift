//
//  PickerKeyboard.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/06/01.
//
// 参考：https://tech.studyplus.co.jp/entry/2018/10/15/114548
import UIKit

class PickerViewKeyboard: UIControl {
    var delegate: PickerViewKeyboardDelegate!
    var pickerView: UIPickerView!

    var data: [String] {
        return delegate.titlesOfPickerViewKeyboard(sender: self)
    }

    private let prefectureRepository = PrefectureRepository()
    private let  pickerViewItemsOfPrefecture = JapanesePrefecture.all.map { prefecture in
        prefecture.nameWithSuffix
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(tappedPickerKeyboard(_:)), for: .touchDown)
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

    @objc func tappedPickerKeyboard(_ sender: PickerViewKeyboard) {
        becomeFirstResponder()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        let space =
        UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        space.width = 10
        let flexSpaceItem =
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem =
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerViewKeyboard.donePicker))
        doneButtonItem.title = "閉じる"

        let toolbarItems = [space, flexSpaceItem, doneButtonItem, space]
        toolbar.setItems(toolbarItems, animated: true)

        return toolbar
    }

    override var inputView: UIView? {
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        let row = delegate.initSelectedRow(sender: self)
        pickerView.selectRow(row, inComponent: 0, animated: true)

        return pickerView
    }
    @objc func donePicker() {
        delegate.didDone(sender: self)
    }
}

extension PickerViewKeyboard: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate.didSelectRow(sender: self, selectedRow: row)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }
}

protocol PickerViewKeyboardDelegate {
    func titlesOfPickerViewKeyboard(sender: PickerViewKeyboard) -> [String]
    func initSelectedRow(sender: PickerViewKeyboard) -> Int
    func didSelectRow(sender: PickerViewKeyboard, selectedRow: Int)
    func didDone(sender: PickerViewKeyboard)
}
