//
//  IdentifiableView.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

protocol IdentifiableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension IdentifiableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension IdentifiableView where Self: UIViewController {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
