//
//  BreedDetailCell.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class BreedDetailCell: UITableViewCell {

    
    
    @IBOutlet weak var viewContainer : UIView?
    @IBOutlet weak var ivBreedImage : UIImageView?
    @IBOutlet weak var lblName : UILabel?
    @IBOutlet weak var lblLifeSpan : UILabel?
    @IBOutlet weak var lblBreedFor : UILabel?
    @IBOutlet weak var lblTemperament : UILabel?
    @IBOutlet weak var lblBreedGroup : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
