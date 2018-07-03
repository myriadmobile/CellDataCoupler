//
//  CouplerTableSource.swift
//
//  Created by Jorny on 5/30/18.
//  Copyright © 2018 Myriad Mobile. All rights reserved.
//

import Foundation

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
        return sections[section].couplers.count
    }
    
    //Cell
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.setupCell(info: sections[indexPath.section].couplers[indexPath.row])
    }
    
    
    //Header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = sections[section].header else {
            return nil
        }
        
        return tableView.setupCell(info: header)
    }
    
    //Footer
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = sections[section].footer else {
            return nil
        }
        
        return tableView.setupCell(info: footer)
    }
}

extension CouplerTableSource: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].couplers[indexPath.row].didSelect?(indexPath)
    }
}
