//
//  BaseTableViewCell.swift
//  Minn-Dak Mobile
//
//  Created by Alex Larson on 8/7/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit
import CellDataCoupler

class BaseTableViewCell<T>: ReusableCell<T> {
    var selectionColor: UIColor?
    
    private func getSelectionColor() -> UIColor? {
        if let selectionColor = selectionColor { return selectionColor }
        
        switch selectionStyle {
        case .blue:
            return .blue
        case .gray:
            return .lightGray
        case .none:
            return nil
        case .default:
            return .lightGray
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted == true {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.getSelectionColor()
                })
                return
            }
            
            backgroundColor = self.getSelectionColor()
        } else {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = .clear
                })
                return
            }
            
            backgroundColor = .clear
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected == true {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.getSelectionColor()
                })
                return
            }
            
            backgroundColor = self.getSelectionColor()
        } else {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = .clear
                })
                return
            }
            
            backgroundColor = .clear
        }
    }
}
