//
//  CDCTableSource.swift
//
//  Created by Jorny on 5/30/18.
//  Copyright © 2018 Myriad Mobile. All rights reserved.
//

import Foundation

open class CDCTableSource: NSObject {
    private var sections: [CDCSection] = []
    public var tableview: UITableView
    
    //Init
    public init(with tableview: UITableView) {
        self.tableview = tableview
        super.init()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.rowHeight = UITableViewAutomaticDimension
    }
    
    
    //Setters
    open func set(sections: [CDCSection]) {
        self.sections = sections
    }
    
    open func set(couplers: [CDCBaseCoupler]) {
        self.sections = [CDCSection(nil, couplers)]
    }
    
    open func set<T>(with items: [T], cellType: CDCReusableCell<T>.Type, didSelect: ((T) -> Void)? = nil) {
        var couplers: [CDCCoupler<T>] = []
        for item in items {
            couplers.append(CDCCoupler(cellType, item) { (indexPath: IndexPath) -> Void in
                didSelect?(item)
            })
        }
        self.sections = [CDCSection(nil, couplers)]
    }
}

extension CDCTableSource: UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].couplers.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.setupCell(info: sections[indexPath.section].couplers[indexPath.row])
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].couplers[indexPath.row]
        let cell = tableView.getCell(forType: row.cellType)
        return cell.frame.height
    }
}

extension CDCTableSource: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].couplers[indexPath.row].didSelect?(indexPath)
    }
}
