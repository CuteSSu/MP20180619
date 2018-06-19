//
//  CosmeticListTableViewController.swift
//  Bcosmetic
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CosmeticTableViewCell: UITableViewCell{
    @IBOutlet var cellName: UILabel!
    @IBOutlet var cellNickname: UILabel!
    @IBOutlet var cellFirstCategory: UILabel!
    @IBOutlet var cellSecondCategory: UILabel!
    @IBOutlet var cellOpendate: UILabel!
    @IBOutlet var cellBbdate: UILabel!
    
}


class CosmeticListTableViewController: UITableViewController {
    
    var cosmetics: [NSManagedObject] = []

    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cosmetics")
      
        let sortDescriptor = NSSortDescriptor (key: "saveDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            cosmetics = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cosmetics.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cosmetics Cell", for: indexPath) as! CosmeticTableViewCell

        // Configure the cell...
        let cosmetic = cosmetics[indexPath.row]
        /*var display: String = ""
        if let nameLabel = friend.value(forKey: "name") as? String {
            display = nameLabel }
        if let phoneLabel = friend.value(forKey: "phone") as? String {
            display = display + " " + phoneLabel }
        cell.textLabel?.text = display
        cell.detailTextLabel?.text = friend.value(forKey: "memo") as? String*/
        cell.cellName?.text = cosmetic.value(forKey: "name") as? String
        cell.cellNickname?.text = cosmetic.value(forKey: "nickname") as? String
        cell.cellFirstCategory?.text = cosmetic.value(forKey: "firstCategory") as? String
        cell.cellSecondCategory?.text = cosmetic.value(forKey: "secondCategory") as? String
        cell.cellOpendate?.text = cosmetic.value(forKey: "opendate") as? String
        //cell.cellBbdate?.text = cosmetic.value(forKey: "bbdate") as? String
        let dbDate: Date? = cosmetic.value(forKey: "expdate") as? Date
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        if let unwrapDate = dbDate {
            let displayDate = formatter.string(from: unwrapDate as Date)
             cell.cellBbdate?.text = displayDate
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let context = getContext()
            context.delete(cosmetics[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            // 배열에서 해당 자료 삭제
            cosmetics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailCosmetic = cosmetics[selectedIndex]
                }
            }
        }
    }
    

}
