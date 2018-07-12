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
        // Static Section
        let name = CellCoupler(FormTestCell.self, "Name: \(person?.name ?? "-")")
        let home = CellCoupler(FormTestCell.self, "Homeworld: \(person?.test ?? "-")")
        let generic = CellCoupler(PersonCell.self, PersonCellData(person, nil)) { (indexPath) -> Void in
            print("Testing")
        }
        
        let testSectionHeader = CellCoupler(SectionHeaderCell.self, "Test Section Test Section Test Section Test Section Test Section Test Section Test Section")
        let staticSection = CellCouplerSection(header: testSectionHeader, couplers: [name, home, generic])
        
        // Dynamic Section
//        let other = CellCoupler(FormTestCell.self, "Some other cell")
//
        let dynamicSectionHeader = CellCoupler(FormTestCell.self, "Other Section")
//        let otherSection = CellCouplerSection(header: otherSectionHeader, couplers: [other])
        
        let dynamicData = ["test1", "test2", "test3"]
        
        let dynamicSection = CellCouplerSection(header: dynamicSectionHeader, factory: CouplerFactory(count: dynamicData.count, couplerFetch: { (index) -> BaseCellCoupler in
            return CellCoupler(SectionHeaderCell.self, dynamicData[index])
        }))
        
        // Update Table
        set(sections: [staticSection, dynamicSection], withReload: false)
        tableview.reloadSections([0, 1], with: .automatic)
    }
}
