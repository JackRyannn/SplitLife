//
//  TodoTableViewCell.swift
//  split
//
//  Created by JackRyannn on 2019/1/17.
//  Copyright © 2019 JackRyannn. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
