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
    var dataNumbers = [[String: String]]()
    var apiNumbers = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food Recipes"
        let query = "https://www.datakick.org/api/items/"
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
        for ingredients in json.arrayValue {
            let gtin14 = ingredients["gtin14"].stringValue// Strings
            let brand_name = ingredients["brand_name"].stringValue
            let name = ingredients["name"].stringValue
            let size = ingredients["size"].stringValue
            let serving_size = ingredients["serving_size"].stringValue
            let servings_per_container = ingredients["servings_per_container"].stringValue
            let calories = ingredients["size"].stringValue// Ints
            let fat_calories = ingredients["size"].stringValue
            let fat = ingredients["size"].stringValue
            let saturated_fat = ingredients["size"].stringValue
            let trans_fat = ingredients["size"].stringValue
            let cholesterol = ingredients["size"].stringValue
            let sodium = ingredients["size"].stringValue
            let carbohydrate = ingredients["size"].stringValue
            let fiber = ingredients["size"].stringValue
            let sugars = ingredients["size"].stringValue
            let protein = ingredients["size"].stringValue
            let url = ingredients["url"].stringValue
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
            recipes.append(foodInformation)
            dataNumbers.append(foodInformationNumbers)
            DispatchQueue.main.async {
                [unowned self] in
                self.tableView.reloadData()
            }
        }
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
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This function goes through every part of the
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let foodInformation = recipes[indexPath.row]//foodInformation["gtin14"] is 'String?'
        cell.textLabel?.text = foodInformation["name"]
        cell.detailTextLabel?.text = foodInformation["brand_name"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! IngredientsViewController
        let index = tableView.indexPathForSelectedRow?.row
        /*
        for 1 in recipes.count {
            if [recipes[index!]] {
                
            }
        }
        */
        dvc.recipe = [recipes[index!]]
        dvc.dataNumbers = [dataNumbers[index!]]
    }
    
}

