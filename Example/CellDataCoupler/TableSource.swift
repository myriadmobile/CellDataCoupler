//
//  TableSource.swift
//  CellDataCoupler_Example
//
//  Created by Alex Larson on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import CellDataCoupler

protocol TableDelegate: class {
}

class TableSource: CouplerTableSource {
    
    weak var delegate: TableDelegate?
    
    init(with tableView: UITableView, delegate: TableDelegate) {
        super.init(with: tableView)
        self.delegate = delegate
    }
    
    func updatePerson(_ person: Person?) {
        let name = Coupler(FormTestCell.self, "Name: \(person?.name ?? "-")")
        let home = Coupler(FormTestCell.self, "Homeworld: \(person?.test ?? "-")")
        let generic = Coupler(PersonCell.self, PersonCellData(person, nil)) { (indexPath) -> Void in
            print("Testing")
        }
        
        set(sections: [CouplerSection("Testing", [name, home, generic])], withReload: false)
        tableview.reloadSections([0], with: .automatic)
    }
}
