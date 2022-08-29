//
//  ContactDetailFeieldTableViewCell.swift
//  TrinityAssessmentProject
//
//  Created by NouraizT on 29/08/2022.
//

import UIKit

class ContactDetailFeieldTableViewCell: UITableViewCell {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var fieldName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
