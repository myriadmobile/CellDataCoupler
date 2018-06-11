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

class TableSource: CDCTableSource {
    
    weak var delegate: TableDelegate?
    
    init(with tableView: UITableView, delegate: TableDelegate) {
        super.init(with: tableView)
        self.delegate = delegate
    }
    
    func updatePerson(_ person: Person?) {
        let name = CDCCoupler(FormTestCell.self, "Name: \(person?.name ?? "-")")
        let home = CDCCoupler(FormTestCell.self, "Homeworld: \(person?.test ?? "-")")
        let generic = CDCCoupler(PersonCell.self, PersonCellData(person, nil)) { (indexPath) -> Void in
            print("Testing")
        }
        
        set(sections: [CDCSection("Testing", [name, home, generic])])
        tableview.reloadData()
    }
}
