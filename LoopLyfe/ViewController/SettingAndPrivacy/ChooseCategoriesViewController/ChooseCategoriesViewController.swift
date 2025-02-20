//
//  ChooseCategoriesViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class ChooseCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var categoriesArr = ["Art & Crafts","Automotive & Transportation","Baby","Beauty","Clothing & Accessories","Education & Training","Electronics","Finance & Investing","Food & Beverage","Media & Entertainment","Personal Blog","Pets","Professional Services","Public Administration","Real Estate","Restaurants & Bars","Shopping & Retail","Software & Apps","Sports, Fitness & Outdoors","Travel & Tourism","Others"]

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var categoriesTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        categoriesTblView.delegate = self
        categoriesTblView.dataSource = self
        categoriesTblView.register(UINib(nibName: "CategoriesTblViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTblViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTblViewCell", for: indexPath) as! CategoriesTblViewCell
        cell.categoriesLbl.text = categoriesArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
