//
//  PersonCell.swift
//  testing
//
//  Created by Jorny on 5/29/18.
//  Copyright © 2018 Myriad Mobile. All rights reserved.
//

import Foundation
import CellDataCoupler

typealias PersonCellData = (person: Person?, action: ((Person) -> Void)?)

class PersonCell: BaseTableViewCell<PersonCellData> {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func setup() {
        myLabel.text = "\(info?.person?.name ?? "")  \(info?.person?.test ?? "")"
    }
}
