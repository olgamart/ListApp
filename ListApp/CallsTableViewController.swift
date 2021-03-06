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
    
    var date_array = [String]() // save data
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let fileURL = self.dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!)) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                date_array.removeAll()
                for i in 0..<array.count {
                    date_array.append(array[i])
                }
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.applicationWillResignActive(notification:)),
            name: Notification.Name.UIApplicationWillResignActive, object: app)
        
//Read calls
        
        if  !date_array.isEmpty {
            callArray.removeAll()
           
            for i in stride(from: 0, to: date_array.count - 3, by: 4) {
                callArray.append(Objects(timeCall: date_array[i], dateCall: date_array[i + 1], callObject: (Contact(name: date_array[i + 2], phone: date_array[i + 3]))))
            }
            
       }
        
       calls_sort()
              
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
        
// write file
        let fileURL = self.dataFileURL()
        date_array.removeAll()
        for callArray in callArray {
            date_array.append(callArray.timeCall)
            date_array.append(callArray.dateCall)
            date_array.append(callArray.callObject.name)
            date_array.append(callArray.callObject.phone)
        }
        
        let array = self.date_array as NSArray
        array.write(to: fileURL as URL, atomically: true)
// end write file
        
        calls_sort()
        
        tableView.reloadData()
    }
   
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return callDataArray[section].dataSection
     }
    
    func calls_sort() {
        // sections by time
        for callArray in callArray {
            if !sections.contains(callArray.timeCall + " " + callArray.dateCall ){
                sections.append(callArray.timeCall + " " + callArray.dateCall)
                sections.sort()
                sections.reverse()
            }
        }
        
    // sections by date
    //        if !sections.contains(callArray.dateCall){
    //           sections.append(callArray.dateCall)
    //           sections.sort()
    //           sections.reverse()
    //       }
        
        
        
        
        callDataArray.removeAll()
        for sections in sections {
            
            for callArray in callArray {
                if sections == callArray.timeCall + " " + callArray.dateCall{   // sections by time
                    //           if sections == callArray.dateCall {   // sections by date
                    subCallArray.append(callArray)
                }
            }
            callDataArray.append(dataObjects(dataSection: sections, dataObjects:subCallArray))
            subCallArray.removeAll()
        }
        
    }
    
    @objc func applicationWillResignActive(notification:NSNotification) {
        
    }
 
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = urls.first!.appendingPathComponent("calls.txt") as NSURL
        return url!
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
