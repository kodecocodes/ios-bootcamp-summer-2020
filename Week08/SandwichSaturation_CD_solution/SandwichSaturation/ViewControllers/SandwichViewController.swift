//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    loadSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    
    let savedScopeIndex = UserDefaults.standard.integer(forKey: "SauceAmountScope")
    searchController.searchBar.selectedScopeButtonIndex = savedScopeIndex
    searchController.searchBar.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func loadSandwiches() {
    do {
      sandwiches = try context.fetch(Sandwich.fetchRequest())
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    if sandwiches.count == 0 {
      loadSandwichesFromJSON()
    }
  }

  func loadSandwichesFromJSON() {
    let sandwichData = SandwichData.storedSandwiches()
    
    sandwichData.forEach { (sandwichData) in
      let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)
      sandwich.name = sandwichData.name
      sandwich.imageName = sandwichData.imageName
      
      // Load the SauceAmountModel
      let sauceAmountModel = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
      sauceAmountModel.sauceAmount = sandwichData.sauceAmount
      sandwich.sauceAmountModel = sauceAmountModel
      
      sandwiches.append(sandwich)
    }
    appDelegate.saveContext()
  }
  
  func saveSandwich(_ sandwichData: SandwichData) {
    let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)
    sandwich.name = sandwichData.name
    sandwich.imageName = sandwichData.imageName
    
    let sauceAmountModel = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
    sauceAmountModel.sauceAmount = sandwichData.sauceAmount
    sandwich.sauceAmountModel = sauceAmountModel
    
    appDelegate.saveContext()
    sandwiches.append(sandwich)
    
    tableView.reloadData()
  }
  
  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>

    var searchPredicates = [NSPredicate]()
    
    let tooMuchSaucePredicate = NSPredicate(format: "sauceAmountModel.sauceAmountString = %@", "Too Much")
    let noSaucePredicate = NSPredicate(format: "sauceAmountModel.sauceAmountString = %@", "None")
    
    if sauceAmount == .any {
      searchPredicates.append(NSCompoundPredicate(orPredicateWithSubpredicates: [tooMuchSaucePredicate, noSaucePredicate]))
    } else {
      searchPredicates.append(NSPredicate(format: "sauceAmountModel.sauceAmountString = %@",
                                          sauceAmount?.rawValue ?? SauceAmount.any.rawValue))
    }

    if !searchText.isEmpty {
      searchPredicates.append(NSPredicate(format: "(name CONTAINS[cd] %@)", searchText))
    }
    
    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: searchPredicates)
    
    do {
      filteredSandwiches = try context.fetch(request)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    if let imageName = sandwich.imageName {
      cell.thumbnail.image = UIImage.init(imageLiteralResourceName: imageName)
    } else {
      cell.thumbnail.image = nil
    }
    cell.nameLabel.text = sandwich.name ?? ""
    cell.sauceLabel.text = sandwich.sauceAmountModel?.sauceAmount.description ?? ""
    
    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    
    // Save to User Defaults
    let defaults = UserDefaults.standard
    defaults.set(selectedScope, forKey: "SauceAmountScope")
    
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}
