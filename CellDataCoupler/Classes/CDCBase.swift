//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class CDCBaseReusableCell: CDCBaseTableViewCell, CDCIdentifiableView {
    open func setupAny(_ info: Any?) {
        print("Warning: You need to override the setup method.")
    }
}

open class CDCReusableCell<T> : CDCBaseReusableCell {
    open func setup(_ info: T?) {
        print("Warning: You need to override the setup method.")
    }
    
    open override func setupAny(_ info: Any?) {
        if let info = info as? CDCCoupler<T> {
            setup(info.data)
        } else if info != nil {
            print("Warning: The data type was not as expected for the ReusableCell.")
        } else {
            setup(nil)
        }
    }
}

open class CDCBaseCoupler: NSObject {
    public var cellType: CDCBaseReusableCell.Type
    public var didSelect: ((IndexPath) -> Void)?
    
    public init(cellType: CDCBaseReusableCell.Type, didSelect: ((IndexPath) -> Void)? = nil) {
        self.cellType = cellType
        self.didSelect = didSelect
    }
}

open class CDCCoupler<T>: CDCBaseCoupler {
    public let data: T?
    
    public init(_ cellType: CDCReusableCell<T>.Type, _ data: T?, didSelect: ((IndexPath) -> Void)? = nil) {
        self.data = data
        super.init(cellType: cellType, didSelect: didSelect)
    }
}

open class CDCSection {
    public var title: String?
    public var couplers: [CDCBaseCoupler] = []
    
    public init(_ title: String?, _ couplers: [CDCBaseCoupler]) {
        self.title = title
        self.couplers = couplers
    }
}
