//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class ReusableCell<T> : BaseReusableCell {
    open func setup(_ info: T?) {
        print("Warning: You need to override the setup method.")
    }
    
    open override func setupAny(_ info: Any?) {
        if let info = info as? CellCoupler<T> {
            setup(info.data)
        } else if info != nil {
            print("Warning: The data type was not as expected for the ReusableCell.")
        } else {
            setup(nil)
        }
    }
}

open class BaseCellCoupler: NSObject {
    public var cellType: BaseReusableCell.Type
    public var didSelect: ((IndexPath) -> Void)?
    
    public init(cellType: BaseReusableCell.Type, didSelect: ((IndexPath) -> Void)? = nil) {
        self.cellType = cellType
        self.didSelect = didSelect
    }
}

open class CellCoupler<T>: BaseCellCoupler {
    public let data: T?
    
    public init(_ cellType: ReusableCell<T>.Type, _ data: T?, didSelect: ((IndexPath) -> Void)? = nil) {
        self.data = data
        super.init(cellType: cellType, didSelect: didSelect)
    }
}

open class CellCouplerSection {
    public var header: BaseCellCoupler?
    public var footer: BaseCellCoupler?
    
    public var factory: CouplerFactory
    
    public init(header: BaseCellCoupler? = nil, footer: BaseCellCoupler? = nil, factory: CouplerFactory) {
        self.header = header
        self.footer = footer
        self.factory = factory
    }
    
    public convenience init(header: BaseCellCoupler? = nil, footer: BaseCellCoupler? = nil, couplers: [BaseCellCoupler]) {
        self.init(header: header, footer: footer, factory: CouplerFactory(couplers: couplers))
    }
}

open class CouplerFactory {
    public typealias CouplerFetch = ((Int) -> BaseCellCoupler)

    public var count: Int
    public var couplerFetch: CouplerFetch
    
    public init(count: Int, couplerFetch: @escaping CouplerFetch) {
        self.count = count
        self.couplerFetch = couplerFetch
    }
    
    public convenience init(couplers: [BaseCellCoupler]) {
        self.init(count: couplers.count) { (index) -> BaseCellCoupler in
            return couplers[index]
        }
    }
}
