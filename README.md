# Summary

CellDataCoupler is a framework written in Swift that helps you to manage tableview with a structure, which binds models to cells and provides them to tables source. With CellDataCoupler, you can make development easier, code more readable, and avoid bad tableview practices.  


* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#basic-usage)
  * [Setup Tableview](#tableview)
  * [Cells](#cells)
  * [Couplers](#couplers)
* [Adavanced Usage](#advanced-usage)
  * [Handling Diffrent Types of Cells](#handling-diffrent-types-of-cells)
  * [Handling Sections](#handling-sections)
  * [Handling Huge Data](#handling-huge-data)
* [Example Project](#example-project)
* [Author](#author)
* [License](#license)


## Requirements
* iOS 8.0+
* Swift 4.0+

## Installation
### CocoaPods
To integrate CellDataCoupler into your project, specify it in your  **Podfile**.

```swift
pod 'CellDataCoupler'
```

## Basic Usage
### Tableview
  CellDataCoupler takes care of jobs that UITableViewDataSource and parts of UITableViewDelegate protocols do. For example, it manages how many rows/sections and provides cells in tableview. It also creates and manages header and footer views if needed. As CellDataCoupler is subclass-friendly, you can subclass to configure heights and estimated heights. Therefore, it helps to save your time for setup tableview related works prone to errors.  
  
  ```swift
  var @IBOutlet weak var tableview: UITableView!
  var tableviewSource: BaseTableSource? 

  func setupTableviewSource() {
    tableviewSource = BaseTableSource(with: tableview)
  }
  ```
  
### Cells  
 A cell used in CellDataCoupler is distinct from UITableViewCell in that CellDataCoupler put logics of a cell in the cell instead of using the tableview delegate method. This makes not only code more readable, but also easier to locate bugs related cells. You can put any logics related to a cell in the setup function. 
  
  ```swift
  struct PersonCellData = {
    var name: String
    var age: Int
  }
  ```
  
  ```swift
  class PersonCell: BaseTableViewCell<PersonCellData> {
    @IBOutlet weak var myLabel: UILabel!
    override func setup() {
        myLabel.text = "\(info?.name ?? "")  \(info?.age ?? 0)"
    }
  }
  ```

### Couplers 
 Consider couplers as the bridge between tableview and cells. You can simply pass the type and data of a cell to CellCoupler. You can also pass a block of codes for handling the selection of a cell if needed. The big advantage of CellDataCoupler is that it handles different types of cells for you. [Check Advanced Usage for details](#advanced-usage). Then, call set function with couplers as the final step for populating data in tableview. 
  
  ```swift
  var couplers = [BaseCoupler]()
  
  let personCoupler = CellCoupler(PersonCell.self, PersonCellData(name: "Mary", age: 28), didSelect: nil)
  couplers.append(personCoupler)
  
  tableviewSource?.set(couplers: couplers)   
  ``` 

## Advanced Usage
### Handling different types of cells
 CellDataCoupler helps you to handle different types of cells. As you do it for one type of cell, you can simply create couplers with different types of cells and data and add them to couplers. Then, just call set function with couplers. 
 
 ```swift
 var couplers = [BaseCoupler]()
 
 let personCoupler = CellCoupler(PersonCell.self, PersonCellData(name: "Smith", age: 34), didSelect: nil)
 couplers.append(personCoupler)
 
 let customerCoupler = CellCoupler(CustomerCell.self, CustomerCellData(customerName: "Mitch", age: 27), didSelect: nil)
 couplers.append(customerCoupler)
 
 tableviewSource?.set(couplers: couplers)
 ```

### Handling Sections
  With CellDataCoupler, you can easily handle static sections like header or footer with a dynamic section like the main part of your tableview content. As you do it for different types of cells, call set function, but with sections. 
  
  ```swift 
  let titleCouper = CellCoupler(TitleLabelCell, TitleCellData(title: "title"), didSelect: nil)
  
  let peopeleCoupler = [BaseCoupler]()
  for person in people {
       let personCoupler = CellCoupler(PersonCell.self, PersonCellData(name: "Pio", age: 17), didSelect: nil)
       peopeleCoupler.append(personCoupler)
  }
  
  tableviewSource?.set(CellCouplerSection(header: titleCoupler, couplers: peopeleCoupler))
  
  ```
  
### Handling Huge Data
 You can utilize **CouplerFactory** when you have to handle huge data in tableview, but want performance. Tableview only populates a few items based on the size of a device. If users scroll down for more items, CouplerFactory provides the next items for tableview using cache. 
 
 Instead of manually creating and adding couplers for a huge amounts of data, you can simply create CouplerFactory with the number of couplers and the coupler fetch, which is responsible for indexing items of data. 
 
 ```swift
 let sectionHeader = CellCoupler(TitleLabelCell, TitleCellData(title: "title"), didSelect: nil)
  
 let itmes = [item1, item2, ..., item100]
 let couplerFactory = CouplerFactory(count: itmes.count, couplerFetch: { (index) -> BaseCellCoupler in
      return CellCoupler(itemCell.self, items[index])
 })
 
 let section = CellCouplerSection(header: sectionHeader, factory: couplerFactory)
 tableviewSource?.set(sections: section) 
 ```

## Example Project
The example project demonstrates how to use CellDataCoupler properly. It shows not only general workflow but also how to subclass TableSource class for more functionality. To run the example project, clone the project. *Don't forget to run ``` pod install ``` first*. 

## Author
Alex Larson, alarson@bushelpowered.com

## License 
CellDataCoupler is available under the MIT license. See the LICENSE file for more info.


