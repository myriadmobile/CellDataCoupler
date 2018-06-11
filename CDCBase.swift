//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

class CDCBaseReusableCell: CDCBaseTableViewCell, IdentifiableView {
    func setupAny(_ info: Any?) {
        print("Warning: You need to override the setup method.")
    }
}

class CDCReusableCell<T> : CDCBaseReusableCell {
    func setup(_ info: T?) {
        print("Warning: You need to override the setup method.")
    }
    
    override func setupAny(_ info: Any?) {
        if let info = info as? CDCCoupler<T> {
            setup(info.data)
        } else if info != nil {
            print("Warning: The data type was not as expected for the ReusableCell.")
        } else {
            setup(nil)
        }
    }
}

class CDCBaseCoupler: NSObject {
    var cellType: CDCBaseReusableCell.Type
    var didSelect: ((IndexPath) -> Void)?
    
    init(cellType: CDCBaseReusableCell.Type, didSelect: ((IndexPath) -> Void)? = nil) {
        self.cellType = cellType
        self.didSelect = didSelect
    }
}

class CDCCoupler<T>: CDCBaseCoupler {
    let data: T?
    init (_ cellType: CDCReusableCell<T>.Type, _ data: T?, didSelect: ((IndexPath) -> Void)? = nil) {
        self.data = data
        super.init(cellType: cellType, didSelect: didSelect)
    }
}

class CDCSection {
    var title: String?
    var couplers: [CDCBaseCoupler] = []
    
    init(_ title: String?, _ couplers: [CDCBaseCoupler]) {
        self.title = title
        self.couplers = couplers
    }
}
