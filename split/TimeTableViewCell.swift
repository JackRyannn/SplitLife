//
//  TimeTableViewCell.swift
//  split
//
//  Created by RenChao on 2018/12/5.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bgImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImageView.image = UIImage.init(named: "time_cell.jpeg")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
