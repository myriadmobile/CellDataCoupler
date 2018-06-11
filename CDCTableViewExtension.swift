//
//  CDCTableViewExtension.swift
//
//  Created by Alex Larson on 12/14/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

extension UITableView {
    func getCell<T: CDCBaseReusableCell>() -> T {
        var cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier)
        if cell == nil {
            self.register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
            cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier)
        }
        
        if (cell as? T) == nil {
            print("Incorrect identifier for cell prototype \(T.defaultReuseIdentifier). Please make sure that the identifier matches the class name.")
        }
        
        return cell as! T
    }
    
    //Nib initialization
    
    func getCell<T: CDCBaseReusableCell>(forType: T.Type) -> T {
        var cell = self.dequeueReusableCell(withIdentifier: forType.defaultReuseIdentifier)
        if cell == nil {
            self.register(UINib(nibName: forType.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: forType.defaultReuseIdentifier)
            cell = self.dequeueReusableCell(withIdentifier: forType.defaultReuseIdentifier)
        }
        
        if (cell as? T) == nil {
            print("Incorrect identifier for cell prototype \(forType.defaultReuseIdentifier). Please make sure that the identifier matches the class name.")
        }
        
        return cell as! T
    }
    
    func setupCell(info: CDCBaseCoupler) -> CDCBaseReusableCell {
        let output = getCell(forType: info.cellType)
        if info.didSelect == nil {
            output.selectionStyle = .none
        }
        output.setupAny(info)
        return output
    }
}
