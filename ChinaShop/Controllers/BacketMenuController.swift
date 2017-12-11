//
//  BacketMenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 20.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class BacketMenuController: UIViewController , UITableViewDelegate, UITableViewDataSource, BasketDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var totalLbl: UILabel!
    
    var orderItemsArray = [MenuItem]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderItemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BacketViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as! BacketViewCell
        
        cell.cellInit(item: orderItemsArray[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func cellViewUpdate(cellId: MenuItem) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.totalLbl.text = self.calculateTotalToString()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderItemsArray = MainService.instance.getBacket()
        print(orderItemsArray.count)
        // Do any additional setup after loading the view.
        totalLbl.text = calculateTotalToString()
    }
    
    func calculateTotalToString() -> String {
        var total = 0.0
        for item in orderItemsArray {
            total += Double(item.count) * item.price
        }
        return "\(total) RMB"
    }
}
