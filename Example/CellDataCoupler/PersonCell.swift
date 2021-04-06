//
//  PersonCell.swift
//  testing
//
//  Created by Jorny on 5/29/18.
//  Copyright © 2018 Myriad Mobile. All rights reserved.
//

import Foundation
import CellDataCoupler

struct PersonCellData {
    var person: Person
}

class PersonCell: BaseTableViewCell<PersonCellData> {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func setup() {
        myLabel.text = "\(info?.person.firstName ?? "")  \(info?.person.lastName ?? "")"
    }
}
