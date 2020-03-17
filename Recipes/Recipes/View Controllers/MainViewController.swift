//
//  MainViewController.swift
//  Recipes
//
//  Created by patelpra on 3/16/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipeDetailViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("There was an error loading recipes, \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    private func filterRecipes() {
        guard let textField = self.textField.text else { return }
        
        if textField.isEmpty {
            self.filteredRecipes = self.allRecipes
        } else {
            self.filteredRecipes = self.allRecipes.filter({$0.name.contains(textField) ||
                $0.instructions.contains(textField)
            })
        }
    }
    

    @IBAction func textField(_ sender: Any) {
        self.textField.resignFirstResponder()
        self.filterRecipes()
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableSegue" {
            self.recipesTableViewController = segue.destination as? RecipeDetailViewController
        }
    }
}
