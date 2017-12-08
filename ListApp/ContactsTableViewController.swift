//
//  ContactsTableViewController.swift
//  ListApp
//
//  Created by Olga Martyanova on 27/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
 
    var contacts = [Contact(name: "Misha", phone: "+79037516521"),
                    Contact(name: "Masha", phone: "+79038716543"),
                    Contact(name: "Anna", phone: "+79018643575"),
                    Contact(name: "Sasha", phone: "+79216543577"),
                    Contact(name: "Olga", phone: "+79308843041"),
                    Contact(name: "Tolik", phone: "+79207753086"),
                    Contact(name: "Tatjana", phone: "+79207743086"),
                    Contact(name: "Elena", phone: "+79045742223")]
 
    
    var sections = [String]()
    var subsection = [Contact]()
    var name = [String]()
    var date_array = [String]() // save data
    
  
    struct Objects {
        var sectionName : String
        var sectionObjects : [Contact]
    }
 
    var objectArray = [Objects]()
    
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
        
       
//Read contacts
 
        if  !date_array.isEmpty {
            contacts.removeAll()
 
             for i in stride(from: 0, to: date_array.count - 1, by: 2) {
                contacts.append(Contact(name: date_array[i], phone: date_array[i + 1]))
            }
       }
 
  
        sort_contacts()
        
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
        return objectArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
     
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row].name
        cell.detailTextLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row].phone

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectArray[section].sectionName
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           
            name.removeAll()
            for contacts in contacts{
                name.append(contacts.name)
            }
            
            let index_remove = name.index(of: objectArray[indexPath.section].sectionObjects[indexPath.row].name)
            contacts.remove(at: index_remove!)
            sort_contacts()
            
// write file
            let fileURL = self.dataFileURL()
            date_array.removeAll()
            for contacts in contacts {
                date_array.append(contacts.name)
                date_array.append(contacts.phone)
            }
            let array = self.date_array as NSArray
            array.write(to: fileURL as URL, atomically: true)
// end write file
            
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
        return false
    }
    

 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 //       let callsTableController = tabBarController?.viewControllers![1] as? CallsTableViewController
        
        let navigationController = tabBarController?.viewControllers![1] as! UINavigationController
        let callsTableController = navigationController.viewControllers[0] as? CallsTableViewController
        
        name.removeAll()
        for contacts in contacts{
            name.append(contacts.name)
        }
        let index_call = name.index(of: objectArray[indexPath.section].sectionObjects[indexPath.row].name)
        
     
        let call = "Call " + contacts[index_call!].name + "?"
        let alert = UIAlertController(title: call, message:nil, preferredStyle: .alert)
        let alertActionCall = UIAlertAction(title: "Call", style: .default){ (alerAction) in
            callsTableController?.addCalls(self.contacts[index_call!])
            
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(alertActionCall)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func sort_contacts() {
        name.removeAll()
        for contacts in contacts{
            name.append(contacts.name)
        }
        
        objectArray.removeAll()
        contacts = contacts.sorted{$0.name < $1.name}
        
        for contacts in contacts{
            let section = String(contacts.name[contacts.name.startIndex])
            
            if !sections.contains(section.uppercased()){
                sections.append(section.uppercased())
            }
        }
        sections.sort()
        
        for sections in sections{
            for contacts in contacts{
                let first_letter = String(contacts.name[contacts.name.startIndex])
                
                if sections == first_letter || sections == first_letter.uppercased(){
                    subsection.append(contacts)
                }
            }
            objectArray.append(Objects(sectionName: sections, sectionObjects: subsection))
            subsection.removeAll()
        }
    }

    @objc func applicationWillResignActive(notification:NSNotification) {
        
 
    }
    
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = urls.first!.appendingPathComponent("data.txt") as NSURL
        return url!
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
