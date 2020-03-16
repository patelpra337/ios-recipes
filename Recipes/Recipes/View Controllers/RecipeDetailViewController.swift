//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by patelpra on 3/16/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var recipes: [Recipe] = []
    
    var recipe: Recipe? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        
    }
    
    private func updateViews() {
        if isViewLoaded {
            self.labelView.text = recipe?.name
            self.textView.text = recipe?.instructions
        }
    }
}
