//
//  CallsTableViewController.swift
//  ListApp
//
//  Created by Olga Martyanova on 29/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class CallsTableViewController: UITableViewController {
 
    var sections = [String]()
    var date_call = ""
    var time_call = ""
   
    struct Objects {
        var timeCall: String
        var dateCall: String
        var callObject : Contact
    }
    
    struct dataObjects {
        var dataSection: String
        var dataObjects: [Objects]
    }
    
    var callArray = [Objects]()
    var subCallArray = [Objects]()
    var callDataArray = [dataObjects]()
    
    
   
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
      
        return callDataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return callDataArray[section].dataObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callCell", for: indexPath) as! CallViewCell
        
   
        cell.setCall(callDataArray[indexPath.section].dataObjects[indexPath.row].callObject,
                     c_time: callDataArray[indexPath.section].dataObjects[indexPath.row].timeCall,
                     c_date: callDataArray[indexPath.section].dataObjects[indexPath.row].dateCall)
       
        return cell
    }
    
    func addCalls(_ call: Contact) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
   
        dateFormatter.dateFormat = "hh:mm"
        time_call = dateFormatter.string(from: date as Date)
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        date_call = dateFormatter.string(from: date as Date)
        
        callArray.append(Objects(timeCall: time_call, dateCall: date_call, callObject: call))
        callArray.reverse()
        
 
// sections by time
       
        
         if !sections.contains(time_call){
             sections.reverse()
             sections.append(time_call)
             sections.reverse()
         }
       
        
// sections by date
//        if !sections.contains(date_call){
//            sections.reverse()
//            sections.append(date_call)
//            sections.reverse()
//        }
        
        
        

       callDataArray.removeAll()
        for sections in sections {
            
            for callArray in callArray {
              if sections == callArray.timeCall {   // sections by time
//            if sections == callArray.dateCall {   // sections by date
                    subCallArray.append(callArray)
                }
            }
            callDataArray.append(dataObjects(dataSection: sections, dataObjects:subCallArray))
            subCallArray.removeAll()
        }
        
        tableView.reloadData()
    }
   
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return callDataArray[section].dataSection
     }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
