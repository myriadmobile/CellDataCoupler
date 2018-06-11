//
//  CDCBaseTableViewCell.swift
//
//  Created by Alex Larson on 8/7/17.
//  Copyright © 2017 Myriad Mobile. All rights reserved.
//

import UIKit

open class CDCBaseTableViewCell: UITableViewCell {
    public var selectionColor: UIColor?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Default values - changing the selection color after the fact (such as in the setup method) will take precedence over this default behavior
        switch selectionStyle {
        case .blue:
            selectionColor = .blue
        case .gray:
            selectionColor = .lightGray
        case .none:
            selectionColor = nil
        case .default:
            selectionColor = .lightGray
        }
    }
    
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted == true {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.selectionColor
                })
                return
            }
            
            backgroundColor = self.selectionColor
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
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        if selected == true {
            if animated == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = self.selectionColor
                })
                return
            }
            
            backgroundColor = self.selectionColor
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
