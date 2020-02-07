//
//  ViewController.swift
//  API Jokes
//
//  Created by Brandon Escobar on 2/6/20.
//  Copyright © 2020 Brandon Escobar. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    var recipes = [[String: String]]()
    //let apiKey = "000000000000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food Recipes"
        let query = "https://www.datakick.org/api/items/"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    if json["status"] == "ok" {
                        self.parse(json: json)
                        return
                    }
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON){
        for ingredients in json["sources"].arrayValue {
            let gtin14 = ingredients["gtin14"].stringValue// Strings
            let brand_name = ingredients["brand_name"].stringValue
            let name = ingredients["name"].stringValue
            let size = ingredients["size"].stringValue
            let serving_size = ingredients["serving_size"].stringValue
            let servings_per_container = ingredients["servings_per_container"].stringValue
            let calories = ingredients["size"].intValue// Ints
            let fat_calories = ingredients["size"].intValue
            let fat = ingredients["size"].intValue
            let saturated_fat = ingredients["size"].intValue
            let trans_fat = ingredients["size"].intValue
            let cholesterol = ingredients["size"].intValue
            let sodium = ingredients["size"].intValue
            let carbohydrate = ingredients["size"].intValue
            let fiber = ingredients["size"].intValue
            let sugars = ingredients["size"].intValue
            let protein = ingredients["size"].intValue
            let foodInformation = ["gtin14" : gtin14,
                          "brand_name" : brand_name,
                          "name" : name, "size" : size,
                          "serving_size" : serving_size,
                          "servings_per_container" : servings_per_container,
                          "calories" : calories, "fat_calories" : fat_calories,
                          "fat" : fat,
                          "saturated_fat" : saturated_fat,
                          "trans_fat" : trans_fat,
                          "cholesterol" : cholesterol,
                          "sodium" : sodium,
                          "carbohydrate" : carbohydrate,
                          "fiber" : fiber,
                          "sugars" : sugars,
                          "protein" : protein] as [String : Any]
            recipes.append(foodInformation as! [String : String])
            DispatchQueue.main.async {
                [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    func loadError() {
    let alert = UIAlertController(title: "Loading Error",
                                message: "There was a problem loading the food ingredients",
                         preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let foodInformation = recipes[indexPath.row]
        cell.textLabel?.text = foodInformation["name"]
        cell.detailTextLabel?.text = foodInformation["description"]
        return cell
    }
}

