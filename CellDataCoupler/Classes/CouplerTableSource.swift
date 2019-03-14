//
//  CouplerTableSource.swift
//
//  Created by Jorny on 5/30/18.
//  Copyright © 2018 Myriad Mobile. All rights reserved.
//

import UIKit

//IMPORTANT: Keep this class in this file. If it is moved to Base.swift - the "set" function with the cellType parameters breaks. We are unsure why.
open class BaseReusableCell: UITableViewCell, IdentifiableView {
    open func setupAny(_ info: Any?) {
        print("Warning: You need to override the setup method.")
    }
}
//IMPORTANT

open class CouplerTableSource: NSObject {
    public var sections: [CellCouplerSection] = []
    public var tableview: UITableView
    
    //Init
    public init(with tableview: UITableView) {
        self.tableview = tableview
        super.init()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    //Setters
    open func set(sections: [CellCouplerSection], withReload: Bool = true) {
        self.sections = sections
        
        if withReload == true {
            tableview.reloadData()
        }
    }
    
    open func set(couplers: [BaseCellCoupler], withReload: Bool = true) {
        self.sections = [CellCouplerSection(couplers: couplers)]
        
        if withReload == true {
            tableview.reloadData()
        }
    }
    
    open func set<T>(with items: [T], cellType: ReusableCell<T>.Type, didSelect: ((T) -> Void)? = nil, withReload: Bool = true) {
        var couplers: [CellCoupler<T>] = []
        for item in items {
            couplers.append(CellCoupler(cellType, item) { (indexPath: IndexPath) -> Void in
                didSelect?(item)
            })
        }
        
        self.sections = [CellCouplerSection(couplers: couplers)]
        
        if withReload == true {
            tableview.reloadData()
        }
    }
}

extension CouplerTableSource: UITableViewDataSource {
    //Counts
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].factory.numberOfItems()
    }
    
    //Cell
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coupler = sections[indexPath.section].factory.getItem(for: indexPath.row) else {
            let errorCell = UITableViewCell()
            errorCell.textLabel?.text = "CellDataCoupler Error - No Coupler Provided!"
            return errorCell
        }
        
        return tableView.setupCell(info: coupler)
    }
    
    
    //Header
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = sections[section].header else {
            return nil
        }
        
        return tableView.setupCell(info: header).contentView
    }
    
    //Footer
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = sections[section].footer else {
            return nil
        }
        
        return tableView.setupCell(info: footer).contentView
    }
}

extension CouplerTableSource: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coupler = sections[indexPath.section].factory.getItem(for: indexPath.row)
        coupler?.didSelect?(indexPath)
    }
    
}
