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
    let calendar = Calendar.current
    var month_str:String = ""

    
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
    
    func setCall(_ contact: Contact) {
        recentName.text = contact.name
        recentNumber.text = contact.phone
        
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let seconds = calendar.component(.second, from: date as Date)
        
        let time_call = String(hour) + ":" + String(minutes) + ":" + String(seconds)
  
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        
        switch Int(month) {
            case 1: month_str = " января "
            case 2: month_str = " февраля "
            case 3: month_str = " марта "
            case 4: month_str = " апреля "
            case 5: month_str = " мая "
            case 6: month_str = " июня "
            case 7: month_str = " июля "
            case 8: month_str = " августа "
            case 9: month_str = " сентября "
            case 10: month_str = " октября "
            case 11: month_str = " ноября "
            case 12: month_str = " декабря "
        default:
            break;
        }
        
        let date_call = String(day) + month_str + String(year)
        
        labelTime.text = time_call
        labelDate.text = date_call
  
    }

}
