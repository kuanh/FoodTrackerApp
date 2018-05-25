//
//  HomeTableViewController.swift
//  FoodTrackerCoreData
//
//  Created by KuAnh on 23/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarMeal: UISearchBar!
    @IBOutlet var viewSearchBarMeal: UIView!
    
    var fetchresult = DataService.shared.fetchResultsController
    
    var filltered: [Meal] = []
    
    var searchActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchresult.delegate = self
        searchBarMeal.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let meal = fetchresult.fetchedObjects else { return }
        filltered = meal.filter({ (meal) -> Bool in
            if meal.name!.lowercased().contains(searchBar.text!.lowercased()) ||  meal.name!.uppercased().contains(searchBar.text!.uppercased()) {
                return true
            } else {
                return false
            }
        })
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchresult.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if fetchresult.sections![section].numberOfObjects == 0 {
            let alert = Helper()
            alert.showAlert(title: "Thông Báo", message: "Không Có Dữ Liệu", fromController: self, preferredStyle: .alert)
            
        }
        
        if searchBarMeal.text != "" {
            return filltered.count
        }else {
            
            return (fetchresult.fetchedObjects?.count)!
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        
        if searchBarMeal.text != "" {
            let arrayMeal = filltered[indexPath.row]
            configureCell(cell, withEvent: arrayMeal)
        } else {
            
            let arrayMeal = fetchresult.object(at: indexPath)
            
            configureCell(cell, withEvent: arrayMeal)
        }
        

        return cell
    }
    
    
    func configureCell(_ cell: HomeTableViewCell, withEvent meal: Meal) {
        
        cell.lbName.text = meal.name?.description
        cell.lbAddress.text = meal.address?.description
        cell.imageMeal.image = meal.image as? UIImage
        cell.lbPostTime.text = "\(meal.postTime)"
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchresult.managedObjectContext
            context.delete(fetchresult.object(at: indexPath))
            do {
                try context.save()
            } catch {
                print("error")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! AddMealViewController
        addVC.meal = fetchresult.object(at: indexPath)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return viewSearchBarMeal
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
 

}

extension HomeTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            configureCell(tableView.cellForRow(at: indexPath!)! as! HomeTableViewCell, withEvent: anObject as! Meal)
        case .move:
            configureCell(tableView.cellForRow(at: indexPath!)! as! HomeTableViewCell, withEvent: anObject as! Meal)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
