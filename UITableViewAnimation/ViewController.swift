//
//  ViewController.swift
//  UITableViewAnimation
//
//  Created by Yoichi on 2019/02/23.
//  Copyright © 2019 Yoichi. All rights reserved.
//

import UIKit

struct CellState {
    var isOpen: Bool
    let backgoundColor: UIColor
    let duration: TimeInterval
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellStates: [CellState] = {
       return [
        CellState(isOpen: true, backgoundColor: .white, duration: 0.1),
        CellState(isOpen: true, backgoundColor: .lightGray, duration: 0.2),
        CellState(isOpen: true, backgoundColor: .white, duration: 0.3),
        CellState(isOpen: true, backgoundColor: .lightGray, duration: 0.4),
        CellState(isOpen: true, backgoundColor: .white, duration: 0.5),
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        let className = "AnimationCell"
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: className)
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellStates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationCell", for: indexPath) as! AnimationCell
        var state = cellStates[indexPath.row]
        cell.refresh(isOpen: state.isOpen, backgroundColor: state.backgoundColor, duration: state.duration)
        cell.toggleButtonTapHandler = { [unowned self] in
            state.isOpen = !state.isOpen
            self.tableView.beginUpdates()
            cell.toggle(isOpen: state.isOpen)
            self.tableView.endUpdates()
        }
        return cell
    }
}
