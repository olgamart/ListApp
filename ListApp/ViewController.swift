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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: UIButton) {
        contactName = nameField.text
        contactPhone = phoneField.text
        let contactsTableController = navigationController?.viewControllers.first as? ContactsTableViewController
    
        contactsTableController?.contacts.append(Contact(name: contactName!, phone: contactPhone!))
        contactsTableController?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
