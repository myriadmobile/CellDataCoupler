//
//  CDCIdentifiableView.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

public protocol CDCIdentifiableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension CDCIdentifiableView where Self: UIView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension CDCIdentifiableView where Self: UIViewController {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
