//
//  ViewController.swift
//  API Jokes
//
//  Created by Brandon Escobar on 2/6/20.
//  Copyright © 2020 Brandon Escobar. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    var sources = [[String: String]]()
    //let apiKey = "000000000000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food Sources"
        let query = "https://www.datakick.org/api/items/"
    }


}

