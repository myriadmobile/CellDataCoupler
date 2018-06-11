//
//  FormTestCell.swift
//  Testing
//
//  Created by Alex Larson on 12/15/17.
//  Copyright © 2017 Alex Larson. All rights reserved.
//

import UIKit
import CellDataCoupler

class FormTestCell: CDCReusableCell<String> {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func setup(_ info: String?) {
        myLabel.text = info
    }
}
