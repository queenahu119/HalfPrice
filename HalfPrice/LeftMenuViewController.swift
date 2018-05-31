//
//  LeftMenuViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 30/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case coles
    case woolworths
    case iga
    case location
    case share
    case feedback
}

protocol LeftMenuProtocol {
    func changeViewController(_ menu: LeftMenu)
}

class LeftMenuViewController: UIViewController, LeftMenuProtocol {

    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Coles", "Woolworths", "IGA", "Location", "Share", "Feedback"]
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
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
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        default:
            break
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

                cell.backgroundColor = UIColor(rgb: 0xF1F8E9, a: 1)
                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
                cell.textLabel?.textColor = UIColor(rgb: 0x9E9E9E, a: 1)
                cell.textLabel?.text = menus[indexPath.row]
                return cell
            default:
                break
            }
        }
        return UITableViewCell()
    }
}
