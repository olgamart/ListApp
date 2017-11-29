//
//  ContactsTableViewController.swift
//  ListApp
//
//  Created by Olga Martyanova on 27/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
 
    var contacts = [Contact(name: "Masha", phone: "+79038716543"),
                    Contact(name: "Misha", phone: "+79037516521"),
                    Contact(name: "Anna", phone: "+79018643575"),
                    Contact(name: "Sasha", phone: "+79216543577"),
                    Contact(name: "Olga", phone: "+79308843041"),
                    Contact(name: "Tatjana", phone: "+79207743086"),
                    Contact(name: "Elena", phone: "+79045742223")]
 
    
 //   var sections = ["A","B","C","D","E","F"]
   
  
//    struct Objects {
//        var sectionName : String
//        var sectionObjects : [Contact]
//    }
 
//    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
 //    return objectArray.count
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
       
  //    return objectArray[section].sectionObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        contacts = contacts.sorted{$0.name < $1.name}
        
          cell.textLabel?.text = contacts[indexPath.row].name
          cell.detailTextLabel?.text = contacts[indexPath.row].phone
        
        
        
    //    cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row].name
    //    cell.detailTextLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row].phone

        return cell
    }
    
   // override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return objectArray[section].sectionName
   // }
   
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    @IBAction func sort(_ sender: UIBarButtonItem) {
        
       contacts = contacts.sorted{$0.name < $1.name}
       self.tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let callsTableController = tabBarController?.viewControllers![1] as? CallsTableViewController
     
        let call = "Call " + contacts[indexPath.row].name + "?"
        let alert = UIAlertController(title: call, message:nil, preferredStyle: .alert)
        let alertActionCall = UIAlertAction(title: "Call", style: .default){ (alerAction) in
            callsTableController?.addCalls(self.contacts[indexPath.row])
            
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(alertActionCall)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
