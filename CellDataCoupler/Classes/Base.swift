//
//  BaseFormInfo.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class ReusableCell<T> : BaseReusableCell {
    public private(set) var info: T?
    
    open func setup() {
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
        
        setup()
    }
}

open class BaseCellCoupler: NSObject {
    public var cellType: BaseReusableCell.Type
    public var didSelect: ((IndexPath) -> Void)?
    public var leadingActions: [UIContextualAction]?
    public var trailingActions: [UIContextualAction]?
    
    public init(cellType: BaseReusableCell.Type, leadingActions: [UIContextualAction]? = nil, trailingActions: [UIContextualAction]? = nil, didSelect: ((IndexPath) -> Void)? = nil) {
        self.cellType = cellType
        self.leadingActions = leadingActions
        self.trailingActions = trailingActions
        self.didSelect = didSelect
    }
}

open class CellCoupler<T>: BaseCellCoupler {
    public let data: T?
    
    public init(_ cellType: ReusableCell<T>.Type, _ data: T?, leadingActions: [UIContextualAction]? = nil, trailingActions: [UIContextualAction]? = nil, didSelect: ((IndexPath) -> Void)? = nil) {
        self.data = data
        super.init(cellType: cellType, leadingActions: leadingActions, trailingActions: trailingActions, didSelect: didSelect)
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
    public typealias MultiCouplerFetch = ((Int) -> [BaseCellCoupler])
    
    private var count: Int
    private var countPerIteration: Int
    private var couplerFetch: MultiCouplerFetch
    private var cached: Bool
    private var cache = [Int: [BaseCellCoupler]]()
        
    public init(iterationCount: Int, couplerCountPerIteration: Int, multiCouplerFetch: @escaping MultiCouplerFetch, cached: Bool = true) {
        self.count = iterationCount
        self.countPerIteration = couplerCountPerIteration
        self.couplerFetch = multiCouplerFetch
        self.cached = cached
    }
    
    public convenience init(count: Int, couplerFetch: @escaping CouplerFetch, cached: Bool = true) {
        let fetch: MultiCouplerFetch = { (index) -> [BaseCellCoupler] in
            return [couplerFetch(index)]
        }
        
        self.init(iterationCount: count, couplerCountPerIteration: 1, multiCouplerFetch: fetch, cached: cached)
    }

    internal convenience init(couplers: [BaseCellCoupler]) {
        self.init(count: couplers.count, couplerFetch: { (index) -> BaseCellCoupler in
            return couplers[index]
        }, cached: false)
    }
    
    public func numberOfItems() -> Int {
        return count * countPerIteration
    }
    
    public func getItem(for index: Int) -> BaseCellCoupler {
        return getItem(for: index, forceCache: false)
    }
    
    internal func getItem(for index: Int, forceCache: Bool) -> BaseCellCoupler {
        let iterationIndex = index / countPerIteration
        let couplerIndex = index % countPerIteration
        
        let forceCache = forceCache || (couplerIndex > 0)
        
        var couplers = [BaseCellCoupler]()
        
        if cached || forceCache, let cachedCouplers = cache[iterationIndex] {
            couplers = cachedCouplers
        } else {
            couplers = couplerFetch(iterationIndex)
            cache[iterationIndex] = couplers
            
            if couplers.count < countPerIteration {
                print("<WARNING> CouplerFactory: You specified \(countPerIteration) couplers would be returned per iteration, but only found \(couplers.count) for index \(iterationIndex).  An empty coupler will be used in its place.")
            }
            
            if couplers.count > countPerIteration {
                print("<WARNING> CouplerFactory: You specified \(countPerIteration) couplers would be returned per iteration, but found \(couplers.count) for index \(iterationIndex).  These extra couplers won't be used.")
            }
        }
        
        guard couplers.count > couplerIndex else {
            return BaseCellCoupler(cellType: EmptyCell.self)
        }
        
        return couplers[couplerIndex]
    }
}
