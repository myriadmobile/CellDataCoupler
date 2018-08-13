//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class ReusableCell<T> : BaseReusableCell {
    public private(set) var info: T?
    
    open func setup(_ info: T?) {
        print("Warning: You need to override the setup method.")
    }
    
    open override func setupAny(_ coupler: Any?) {
        if let coupler = coupler as? CellCoupler<T> {
            info = coupler.data
        } else if coupler != nil {
            info = nil
            print("Warning: The data type was not as expected for the ReusableCell.")
        } else {
            info = nil
        }
        
        setup(info)
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

    private var count: Int
    private var couplerFetch: CouplerFetch
    private var cache: [Int: BaseCellCoupler]?
    
    public init(count: Int, couplerFetch: @escaping CouplerFetch, cached: Bool = true) {
        self.count = count
        self.couplerFetch = couplerFetch
        cache = cached ? [:] : nil
    }
    
    internal convenience init(couplers: [BaseCellCoupler]) {
        self.init(count: couplers.count, couplerFetch: { (index) -> BaseCellCoupler in
            return couplers[index]
        }, cached: false)
    }
    
    public func numberOfItems() -> Int {
        return count
    }
    
    public func getItem(for index: Int) -> BaseCellCoupler {
        if let cache = cache, let cachedItem = cache[index] {
            return cachedItem
        }
        
        let item = couplerFetch(index)
        cache?[index] = item
        return item
    }
}
