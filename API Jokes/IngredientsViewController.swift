//
//  ViewController.swift
//  API Jokes
//
//  Created by Brandon Escobar on 2/11/20.
//  Copyright © 2020 Brandon Escobar. All rights reserved.
//

import UIKit

class IngredientsViewController: UITableViewController {
    
    var information = [[String: String]]()
    var recipe = [[String: String]]()
    var dataNumbers = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let apiKey = recipe["gtin14"]
        //print(recipe)
        let item = recipe.first!
        let itemNumber = item["gtin14"]!
        //print(itemNumber)
        self.title = "Food Ingredients"
        let query = "https://www.datakick.org/api/items/\(itemNumber)"//\(itemNumber)
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON){
        //print(json)
        let gtin14 = json["gtin14"].stringValue// Strings
        let brand_name = json["brand_name"].stringValue
        let name = json["name"].stringValue
        let size = json["size"].stringValue
        let serving_size = json["serving_size"].stringValue
        let servings_per_container = json["servings_per_container"].stringValue
        let url = json["url"].stringValue
        let calories = json["calories"].stringValue// Ints
        let fat_calories = json["fat_calories"].stringValue
        let fat = json["fat"].stringValue
        let saturated_fat = json["saturated_fat"].stringValue
        let trans_fat = json["trans_fat"].stringValue
        let cholesterol = json["cholesterol"].stringValue
        let sodium = json["sodium"].stringValue
        let carbohydrate = json["carbohydrate"].stringValue
        let fiber = json["fiber"].stringValue
        let sugars = json["sugars"].stringValue
        let protein = json["protein"].stringValue
        let foodInformation = ["gtin14" : gtin14,
                           "brand_name" : brand_name,
                                 "name" : name,
                                 "size" : size,
                         "serving_size" : serving_size,
               "servings_per_container" : servings_per_container,
                                  "url" : url]
                let foodInformationNumbers =
                            ["calories" : calories,
                         "fat_calories" : fat_calories,
                                  "fat" : fat,
                        "saturated_fat" : saturated_fat,
                            "trans_fat" : trans_fat,
                          "cholesterol" : cholesterol,
                               "sodium" : sodium,
                         "carbohydrate" : carbohydrate,
                                "fiber" : fiber,
                               "sugars" : sugars,
                              "protein" : protein]
            information.append(foodInformation)
            information.append(foodInformationNumbers)
        //print(information)
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
        //self.tableView.reloadData()
    }
    
    func loadError() {
        DispatchQueue.main.async {
           [unowned self] in
           let alert = UIAlertController(title: "Loading Error",
                                       message: "There was a problem loading the food ingredients",
                                preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let foodInformation = information[indexPath.row]
        //var boi = ""
        /*
        for i in foodInformation {
            boi += foodInformation["name"]!
        }
        */
        print(foodInformation["name"] as Any)
        cell.textLabel?.text = foodInformation["name"]
        cell.textLabel?.text = foodInformation["brand_name"]
        cell.textLabel?.text = foodInformation["gtin14"]
        //cell.textLabel?.text = foodNumbers["name"]
        cell.detailTextLabel?.text = foodInformation["brand_name"]
        return cell
    }
}

