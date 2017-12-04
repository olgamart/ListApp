//
//  ViewController.swift
//  ListApp
//
//  Created by Olga Martyanova on 27/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var contactName: String?
    var contactPhone: String?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       nameField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameField.becomeFirstResponder()
    }

    @IBAction func add(_ sender: UIButton) {
        contactName = nameField.text
        contactPhone = phoneField.text        
        
        let contactsTableController = navigationController?.viewControllers.first as? ContactsTableViewController
        
        
        if contactName != "" && contactPhone != "" {
            if !(contactsTableController?.name.contains(contactName!))!{
            
            contactsTableController?.contacts.append(Contact(name: contactName!, phone: contactPhone!))
            contactsTableController?.sort_contacts()
            
            } else {
                
                let alert = UIAlertController(title: nil, message:"This name is already exist", preferredStyle: .alert)
                let alertActionAdd = UIAlertAction(title: "Rename", style: .default){ (alerAction) in self.nameField.becomeFirstResponder()
                    
                }
                let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) {(alerAction) in
                     self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(alertActionAdd)
                alert.addAction(alertActionCancel)
                self.present(alert, animated: true, completion: nil)
                
                }
            
        }
        
        contactsTableController?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
        
    }
}
