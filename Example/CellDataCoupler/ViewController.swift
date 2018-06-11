//
//  ViewController.swift
//  CellDataCoupler
//
//  Created by Alex Larson on 06/11/2018.
//  Copyright (c) 2018 Alex Larson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: Presenter!
    var tableSource: TableSource?
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            presenter = Presenter(with: self)
        }
        
        setupTableSource()
        presenter.start()
    }
    
    func setupTableSource() {
        tableSource = TableSource(with: tableView, delegate: self)
    }
}

extension ViewController: ViewDelegate {
    func retrievedPerson(_ person: Person?) {
        tableSource?.updatePerson(person)
    }
}

extension ViewController: TableDelegate {
    
}
