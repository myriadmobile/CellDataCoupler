//
//  Presenter.swift
//  CellDataCoupler_Example
//
//  Created by Alex Larson on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol ViewDelegate: class {
    func retrievedPerson(_ person: Person)
}

//No return statements
class Presenter: NSObject {
    
    weak var view: ViewDelegate?
    
    init(with view: ViewDelegate) {
        self.view = view
    }
    
    func start() {
        getPerson(true)
    }
}

//API
extension Presenter {
    func getPerson(_ refresh: Bool = false) {
        let person = Person(firstName: "firstName", lastName: "lastName")
        self.view?.retrievedPerson(person)
    }
}


struct Person
{
    var firstName: String?
    var lastName: String?
}
