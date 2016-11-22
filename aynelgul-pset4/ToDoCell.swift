//
//  ToDoCell.swift
//  aynelgul-pset4
//
//  Created by Aynel Gül on 22-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoSwitch: UISwitch!
    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBAction func switchAction(_ sender: UISwitch) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
