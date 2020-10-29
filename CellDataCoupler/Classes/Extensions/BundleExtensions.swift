//
//  BundleExtensions.swift
//  CellDataCoupler
//
//  Created by Jangle's MacBook Pro on 10/29/20.
//

import Foundation

internal extension Bundle {
    static var podBundle: Bundle {
        return Bundle(for: CouplerTableSource.self)
    }    
}
