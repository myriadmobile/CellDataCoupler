//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class BaseReusableCell: UITableViewCell, IdentifiableView {
    open func setupAny(_ info: Any?) {
        print("Warning: You need to override the setup method.")
    }
}

open class ReusableCell<T> : BaseReusableCell {
    open func setup(_ info: T?) {
        print("Warning: You need to override the setup method.")
    }
    
    open override func setupAny(_ info: Any?) {
        if let info = info as? Coupler<T> {
            setup(info.data)
        } else if info != nil {
            print("Warning: The data type was not as expected for the ReusableCell.")
        } else {
            setup(nil)
        }
    }
}

//Cell
open class BaseCoupler: NSObject {
    public let cellType: BaseReusableCell.Type
    public let didSelect: ((IndexPath) -> Void)?
    
    public init(cellType: BaseReusableCell.Type, didSelect: ((IndexPath) -> Void)? = nil) {
        self.cellType = cellType
        self.didSelect = didSelect
    }
}

open class Coupler<T>: BaseCoupler {
    public let data: T?
    
    public init(_ cellType: ReusableCell<T>.Type, _ data: T?, didSelect: ((IndexPath) -> Void)? = nil) {
        self.data = data
        super.init(cellType: cellType, didSelect: didSelect)
    }
}

//Section
open class BaseSection: NSObject {
    public let couplers: [BaseCoupler]
    
    public init(couplers: [BaseCoupler]) {
        self.couplers = couplers
    }
}

open class CouplerSection<T>: BaseSection {
    public let headerType: BaseReusableCell.Type?
    public let headerData: T?
    
    public var footerType: BaseReusableCell.Type?
    public var footerData: T?
    
    public init(_ headerType: ReusableCell<T>.Type?, _ headerData: T?, _ couplers: [BaseCoupler]) {
        self.headerType = headerType
        self.headerData = headerData
        super.init(couplers: couplers)
    }
}
