//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by patelpra on 3/16/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = self.recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailRecipe" {
            guard let indexPath = self.tableView.indexPathForSelectedRow,
                let recipeDetailVC = segue.destination as? RecipeDetailViewController else { return }
            
            let recipe = self.recipes[indexPath.row]
            recipeDetailVC.recipe = recipe
        }
    }
}
