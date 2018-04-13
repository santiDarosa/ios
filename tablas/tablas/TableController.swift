//
//  TableController.swift
//  tablas
//
//  Created by SP 25 on 12/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "TomateCell"
        
        let cell = table2.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
    }
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //}
    

    @IBOutlet weak var table2: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table2.delegate = self
        table2.dataSource = self
        table2.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}
