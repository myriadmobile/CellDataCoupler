//
//  SectionHeaderCell.swift
//  CellDataCoupler_Example
//
//  Created by Alex Larson on 6/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class SectionHeaderCell: BaseTableViewCell<String> {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func setup() {
        myLabel.text = info
    }
}
