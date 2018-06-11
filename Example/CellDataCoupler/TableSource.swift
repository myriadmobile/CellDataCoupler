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

class TableSource: CDCSource {
    
    weak var delegate: TableDelegate?
    
    init(with tableView: UITableView, delegate: TableDelegate) {
        super.init(with: tableView)
        self.delegate = delegate
    }
    
    func updatePerson(_ person: Person?) {
        let name = CellDataCoupler(FormTestCell.self, "Name: \(person?.name ?? "-")")
        let home = CellDataCoupler(FormTestCell.self, "Homeworld: \(person?.test ?? "-")")
        let generic = CellDataCoupler(PersonCell.self, PersonCellData(person, nil)) { (indexPath) -> Void in
            print("Testing")
        }
        reload(with: [CellDataSection("Testing", [name, home, generic])])
    }
}
