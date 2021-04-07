//
//  ListTableViewCell.swift
//  MachineTest
//
//  Created by Nilesh Gadhe on 07/04/21.
//  Copyright © 2021 Innofied. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    
    @IBOutlet weak var imgViewUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgViewUser.layer.cornerRadius = imgViewUser.bounds.height / 2
        imgViewUser.layer.masksToBounds = false
        imgViewUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
