//
//  ParkingTableViewCell.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 02/02/23.
//

import UIKit

class ParkingTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleCoordiateLbl: UILabel!
    @IBOutlet weak var descriptionCoordinateLbl: UILabel!
    
    @IBOutlet weak var bookBtnPrp: UIButton!
    @IBOutlet weak var detailsBtnPrp: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func bookBtnAction(_ sender: Any) {
    }
    
    
    @IBAction func detailsBtnAction(_ sender: Any) {
    }
    
    
}
