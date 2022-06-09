//
//  SearchViewController.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/27.
//

import UIKit
import GoogleMobileAds

class SearchViewController: UIViewController {
    @IBOutlet weak private var categorySegumentControl: UISegmentedControl!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!

    // Google広告に用いるプロパティ
    @IBOutlet weak private var bannerView: GADBannerView!

    // 検索の際に用いるプロパティ
    var searchTimer: Timer?
    // インジゲーターの設定
    var indicator = UIActivityIndicatorView()
    private var searchString: String = ""

    var filitedfacilityInformation: [FacilityInformation] = []
    private var selectedFacilityInformation: FacilityInformation?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBarTextFieldSetting()
        configureIndicatorSetting()
        configureAdBannar()
    }
    @IBAction private func tapSegmentedControl(_ sender: Any) {
        searchAndReloadTableViewAndAnimationindicator(searchText: searchString)
    }

    // 参考：https://www.letitride.jp/entry/2019/08/19/155333
    func configureSearchBarTextFieldSetting() {
        // ツールバー生成 サイズはsizeToFitメソッドで自動で調整される。
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        // サイズの自動調整。敢えて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さない。
        toolBar.sizeToFit()

        // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
        let spacer = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: self, action: nil
        )
        // Doneボタン
        // let commitButton = UIBarButtonItem(
//    barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(commitButtonTapped))
        // 日本語名に変更。
        let commitButton = UIBarButtonItem(
            title: "閉じる",
            style: .plain,
            target: self, action: #selector(commitButtonTapped)
        )
        // BarButtonItemの配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        searchBar.searchTextField.inputAccessoryView = toolBar
    }

    // TextFieldのツールバーの閉じるボタンが押されたときの処理。
    @objc func commitButtonTapped() {
        view.endEditing(true)
    }

    // 参考：https://cpoint-lab.co.jp/article/201911/12587/
    func configureIndicatorSetting() {
        // 表示位置を設定（画面中央）
        indicator.center = view.center
        // インジケーターのスタイルを指定（白色＆大きいサイズ）
        indicator.style = .large
        // インジケーターの色を設定（青色）
        indicator.color = UIColor(named: "Color")
        // インジケーターを View に追加
        view.addSubview(indicator)
    }
    private func configureAdBannar() {
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = "\(GoogleAdID.bannerID)"
        bannerView.rootViewController = self

        // 広告読み込み
        bannerView.load(GADRequest())
    }

    private func searchAndReloadTableViewAndAnimationindicator(searchText: String) {
        // インジケーターを表示＆アニメーション開始
        indicator.startAnimating()

        let dispatchQueue = DispatchQueue.global()
        // 変数の宣言の部分で、searchTimerを宣言しています。
        searchTimer?.invalidate()
        // withTimeIntervalの部分で、○○秒入力がなければ、下の処理が行われない実装に
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {[weak self] _ in
            if searchText == "" {
                // 読込はメインスレッドを用いない
                dispatchQueue.async {[weak self] in
                    //                    self?.foodListForTableView = (self?.convertAllFoodObjectToArray())!
                    self?.filitedfacilityInformation = []
                    // テーブルビューの更新はメインスレッドを用いる
                    DispatchQueue.main.async {[weak self] in
                        // インジケーターを非表示＆アニメーション終了
                        self?.indicator.stopAnimating()
                        self?.tableView.reloadData()
                    }
                }
            } else {
                let filterSearch: FilterSearch
                switch self?.categorySegumentControl.selectedSegmentIndex {
                case 0:
                    // 事業所名
                    filterSearch = FilterSearch(string: "事業所名")
                case 1:
                    // 会社名
                    filterSearch = FilterSearch(string: "会社名")
                case 2:
                    // 住所
                    filterSearch = FilterSearch(string: "住所")
                default:
                    fatalError("Segumentが選択されていない。")
                }
                // 読込はメインスレッドを用いない
                dispatchQueue.async {[weak self] in
                    self?.filitedfacilityInformation =
                    UseCaseSearch.filteredSearchFacilityInformation(
                        filterServiceType: .all,
                        filterSearch: filterSearch,
                        string: searchText
                    )
                    // テーブルビューの更新はメインスレッドを用いる
                    DispatchQueue.main.async {[weak self] in
                        // インジケーターを非表示＆アニメーション終了
                        self?.indicator.stopAnimating()
                        self?.tableView.setContentOffset(.zero, animated: true)
                        self?.tableView.reloadData()
                    }
                }
            }
        })
    }
}
// MARK: - Segue
extension SearchViewController {
    @IBSegueAction
    func makeDetailSearch(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> DetailSearchViewController? {
        DetailSearchViewController(
            coder: coder,
            facilityInformation: selectedFacilityInformation!,
            transitionSource: .searchViewController
        )
    }

    // swiftlint:disable:next private_action
    @IBAction func backToSearchViewController(segue: UIStoryboardSegue) {
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filitedfacilityInformation.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView
            .dequeueReusableCell(
                withIdentifier: "searchCell"
            ) as? SearchTableViewCell else { fatalError() }
        // 緯度、経度が空文字だった場合は、true、それ以外は、false
        let isHiddenMapAttention =
        filitedfacilityInformation[indexPath.row].latitude != "" ||
        filitedfacilityInformation[indexPath.row].longitude != ""
        switch categorySegumentControl.selectedSegmentIndex {
        case 0:
            // 事業所名
            cell.configure(
                firstTitle: "事業所名",
                firstInformation: filitedfacilityInformation[indexPath.row].officeName,
                secondTitle: "住所",
                secondInformation: filitedfacilityInformation[indexPath.row].address,
                isHiddenMapAttention: isHiddenMapAttention
            )
        case 1:
            // 会社名

            cell.configure(
                firstTitle: "事業所名",
                firstInformation: filitedfacilityInformation[indexPath.row].officeName,
                secondTitle: "会社名",
                secondInformation: filitedfacilityInformation[indexPath.row].corporateName,
                isHiddenMapAttention: isHiddenMapAttention
            )
        case 2:
            //　住所

            cell.configure(
                firstTitle: "事業所名",
                firstInformation: filitedfacilityInformation[indexPath.row].officeName,
                secondTitle: "住所",
                secondInformation: filitedfacilityInformation[indexPath.row].address,
                isHiddenMapAttention: isHiddenMapAttention
            )
        default:
            fatalError("segumentが選択されていません。")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFacilityInformation = filitedfacilityInformation[indexPath.row]
        if selectedFacilityInformation != nil {
            performSegue(withIdentifier: "detailSearch", sender: nil)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        searchAndReloadTableViewAndAnimationindicator(searchText: searchString)
    }
}
