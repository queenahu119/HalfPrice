//
//  LeftMenuViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 30/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import SnapKit

enum LeftMenu: Int {
    case main = 0
    case coles
    case woolworths
    case iga
    case location
    case share
    case feedback
}

enum Size {
    static let heightOfHeaderView = 160
}

protocol LeftMenuProtocol {
    func changeViewController(_ menu: LeftMenu)
}

class LeftMenuViewController: UIViewController, LeftMenuProtocol {

    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Coles", "Woolworths", "IGA", "Location", "Share", "Feedback"]
    var mainViewController: UIViewController!
    var feedbackViewController: UIViewController!

    var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.themeBackground
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(self.headerView)

        self.tableView.separatorStyle = .none

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let feedbackViewController = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        self.feedbackViewController = UINavigationController(rootViewController: feedbackViewController)

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }

    func changeViewController(_ menu: LeftMenu) {

        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .feedback:
            self.slideMenuController()?.changeMainViewController(self.feedbackViewController, close: true)
        default:
            break
        }
    }

    func setupUI() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(Size.heightOfHeaderView)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Size.heightOfHeaderView)
        }
    }
}

extension LeftMenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .feedback:
                return 48
            default:
                break
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {

        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .feedback:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellId", for: indexPath)

                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
                cell.textLabel?.textColor = UIColor.black
                cell.textLabel?.text = menus[indexPath.row]
                return cell
            default:
                break
            }
        }
        return UITableViewCell()
    }
}
