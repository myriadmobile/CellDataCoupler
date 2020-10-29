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
    
    func updatePerson(_ person: Person) {
        // Static Section
        let exampleHeader = CellCoupler(SectionHeaderCell.self, "Example Header")
        let personCoupler = CellCoupler(PersonCell.self, PersonCellData(person: person)) // Not selectable
        let selectableCoupler = CellCoupler(FormTestCell.self, "Click Me!") { (indexPath) -> Void in
            print("Good Job")
        }
        
        let staticSection = CellCouplerSection(header: exampleHeader, couplers: [personCoupler, selectableCoupler])
        
        // Dynamic Section
        let dynamicSectionHeader = CellCoupler(SectionHeaderCell.self, "Dynamic Section")
        
        // Pretend this data is Realm.Results or something we can query on the fly.
        // CouplerFactory is also useful if your cell couplers require a lot of operations to set up.
        let dynamicData = ["Example 1", "Example 2", "Example 3", "Example 4", "Example 5", "Example 6", "Example 7", "Example 8", "Example 9", "Example 10"]
        
        let factory = CouplerFactory(count: dynamicData.count, couplerFetch: { (index) -> BaseCellCoupler in
            let data = dynamicData[index]
            return CellCoupler(FormTestCell.self, data) { (_) in
                print("Selected: \(data)")
            }
        })
        
        // Example of a retrieving multiple couplers per model index
        // Length of array returned must be the same as specified in couplerCountPerIteration
//        let factory = CouplerFactory(iterationCount: dynamicData.count, couplerCountPerIteration: 3) { (index) -> [BaseCellCoupler] in
//            let data = dynamicData[index]
//
//            let coupler = CellCoupler(FormTestCell.self, data) { (_) in
//                print("Selected: \(data)")
//            }
//
//            // Normally, you'd make more than one coupler.  I'm being lazy and reusing it.
//
//            return [coupler, coupler, coupler]
//        }
        
        let dynamicSection = CellCouplerSection(header: dynamicSectionHeader, factory: factory)
        
        // Update Table
        set(sections: [staticSection, dynamicSection], withReload: false)
        tableview.reloadSections([0, 1], with: .automatic)
    }
}
