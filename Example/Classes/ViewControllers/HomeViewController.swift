//
//  HomeViewController.swift
//  FiveUtils
//
//  Created by Miran Brajsa on 09/17/2016.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate let viewModel: HomeViewModel
    
    @IBOutlet private weak var tableView: UITableView!

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not be implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        setupLayout()
    }

    private func setupContent() {
        let cellReuseIdentifier = String(describing: ContentCell.self)
        tableView.register(
            UINib(nibName: cellReuseIdentifier, bundle: nil),
            forCellReuseIdentifier: cellReuseIdentifier
        )
        tableView.estimatedRowHeight = 100
    }

    private func setupLayout() {
        guard let titleFont = UIFont.screenTitleTextFont() else { return }

        title = "Five Utils"
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.highlightRedColor(),
            NSFontAttributeName: titleFont
        ]
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self), for: indexPath) as? ContentCell
            else {
                return UITableViewCell()
        }
        

        let cellViewModel = viewModel.cellViewModel(atIndex: indexPath.row)
        cell.setup(withViewModel: cellViewModel)
        return cell
    }
}
