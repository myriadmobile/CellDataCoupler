//
//  IdentifiableView.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

public protocol IdentifiableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension IdentifiableView where Self: UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
