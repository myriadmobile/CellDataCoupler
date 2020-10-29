//
//  EmptyCell.swift
//  CellDataCoupler
//
//  Created by Jangle's MacBook Pro on 10/29/20.
//

import UIKit

class EmptyCell: BaseReusableCell, BundledIdentifiableView {
    static var bundle: Bundle? {
        return .podBundle
    }
    
    override func setupAny(_ info: Any?) {
        // It's empty
    }
}
