//
//  BreedInfoCell.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class BreedInfoCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel?
    @IBOutlet weak var lblLifeSpan : UILabel?
    @IBOutlet weak var lblBreedFor : UILabel?
    @IBOutlet weak var ivDog : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(objBreednfo: BreedInfo)
    
    {
        if(objBreednfo.breeds?.count ?? 0 > 0)
        {
            let objBreedInfo :  Breed? = objBreednfo.breeds?[0]
            self.lblTitle?.text = String(format: "Name: %@", objBreedInfo?.name ?? "")
            self.lblLifeSpan?.text = String(format: "Life-Span: %@", objBreedInfo?.lifeSpan ?? "")
            self.lblBreedFor?.text = String(format: "Breed For: %@", objBreedInfo?.bredFor ?? "")
        }

        
        let strURL : String? = String(format: "%@",objBreednfo.url ?? String() )
        let url = URL(string: strURL ?? String())
        
        self.ivDog?.sd_setImage(with: url, placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil)
            {
                self.ivDog?.image  = UIImage(named:"No_Image_Found")
                
            } else
            {
                self.ivDog?.image = image
            }
        })
        
    
    }

}
