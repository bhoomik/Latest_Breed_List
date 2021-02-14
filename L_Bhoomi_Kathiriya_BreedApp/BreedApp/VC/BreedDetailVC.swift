//
//  BreedDetailVC.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class BreedDetailVC: UIViewController
{
    
    var objBreedDetail : BreedInfo?
    var imgBreed : UIImage?
    @IBOutlet weak var tblBreedDetail : UITableView?
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }
    
    func commonInit()  {
        self.title =  "Breed Detail"
        tblBreedDetail?.estimatedRowHeight = 100
        tblBreedDetail?.rowHeight = UITableView.automaticDimension
        
    }
    
    
    
    @objc func imageTapped(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "BreedDetailToImage", sender: self)
    }
    
    //MARK: Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Set Data
    func setBreedDetail(breed:BreedInfo)
    {
        self.objBreedDetail = breed
    }
    
    
    //MARK: Navigation

    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "BreedDetailToImage")
        {
            let objVC : ImageViewVC = segue.destination  as! ImageViewVC
            objVC.setImageDetail(image: self.imgBreed!)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension BreedDetailVC : UITableViewDelegate,UITableViewDataSource

{
    //MARK: UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : BreedDetailCell = tableView.dequeueReusableCell(withIdentifier: "BreedDetailCell", for: indexPath) as! BreedDetailCell
        let strURL = String(format: "%@",(self.objBreedDetail?.url)!)
        print("string url is",strURL)
       let tap = UITapGestureRecognizer(target: self, action: #selector(BreedDetailVC.imageTapped))
        cell.ivBreedImage?.isUserInteractionEnabled = true
        cell.ivBreedImage?.addGestureRecognizer(tap)
        
        let url = URL(string: strURL)
        
        if(self.objBreedDetail?.breeds?.count ?? 0 > 0)
        {
            let objBreedInfo :  Breed? = self.objBreedDetail?.breeds?[0]
            cell.lblName?.text = String(format: "Name: %@", objBreedInfo?.name ?? "")
            cell.lblLifeSpan?.text = String(format: "Life-Span: %@", objBreedInfo?.lifeSpan ?? "")
            cell.lblBreedFor?.text = String(format: "Breed For: %@", objBreedInfo?.bredFor ?? "")
            cell.lblTemperament?.text = String(format: "Temperament: %@", objBreedInfo?.temperament ?? "")
            cell.lblBreedGroup?.text = String(format: "Breed Group: %@", objBreedInfo?.breedGroup ?? "")
        }
        cell.ivBreedImage?.sd_setImage(with: url, placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil)
            {
                cell.ivBreedImage?.image  = UIImage(named:"No_Image_Found")
                self.imgBreed = cell.ivBreedImage?.image
                // set the placeholder image here
                
            } else
            {
                cell.ivBreedImage?.image = image
                self.imgBreed = cell.ivBreedImage?.image
            }
        })
        
        return cell
    }
    
    
    
    
    
}
