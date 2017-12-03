//
//  CallViewCell.swift
//  ListApp
//
//  Created by Olga Martyanova on 29/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class CallViewCell: UITableViewCell {


    let date = Date()
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var recentName: UILabel!
    @IBOutlet weak var recentNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCall(_ contact: Contact, c_time: String, c_date: String) {
        recentName.text = contact.name
        recentNumber.text = contact.phone
  
        labelTime.text = c_time
        labelDate.text = c_date
    }

}
