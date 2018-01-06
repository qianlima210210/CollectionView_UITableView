//
//  PersonTableViewCell.swift
//  CommunicationList
//
//  Created by QDHL on 2017/12/30.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTable: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
