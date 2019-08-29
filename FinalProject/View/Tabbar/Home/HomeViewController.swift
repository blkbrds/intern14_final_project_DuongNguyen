//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
    }

    // MARK: - Custom funcs
    private func configTableView() {
        tableView.register(UINib(nibName: "SliderImageCell", bundle: nil), forCellReuseIdentifier: "SliderImageCell")
        tableView.register(UINib(nibName: "ListSearchCell", bundle: nil), forCellReuseIdentifier: "ListSearchCell")
        tableView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellReuseIdentifier: "ChannelCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        title = "HOME"
    }

    // MARK: - Actions
}

// MARK: - Extensions
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 4:
            return 10
        default:
            return 1
        }
    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Ahihi"
//    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
//            let view = Bundle.main.loadNibNamed("HearderView", owner: self, options: nil)?.first as? UIView
            let view = UIView()
            let label = Label(frame: CGRect(x: 5, y: 5, width: 100, height: 30))
            label.text = "Ahihi"
            view.addSubview(label)
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1, 2, 3:
            return 100
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SliderImageCell", for: indexPath) as? SliderImageCell else {
                return UITableViewCell()
            }
            return cell
        case 1, 2, 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListSearchCell", for: indexPath) as? ListSearchCell else {
                return UITableViewCell()
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ListSearchCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {

}
