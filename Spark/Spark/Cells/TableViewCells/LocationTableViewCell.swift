//
//  LocationTableViewCell.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 07/02/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationBgView: UIView!
    @IBOutlet weak var locationTitleLbl: UILabel!
    @IBOutlet weak var locationDescriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
