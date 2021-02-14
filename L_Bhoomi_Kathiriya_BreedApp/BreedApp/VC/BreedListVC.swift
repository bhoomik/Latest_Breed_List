//
//  BreedListVC.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit
import MBProgressHUD
let APPDELEGATE         = UIApplication.shared.delegate as! AppDelegate //AppDelegate


class BreedListVC: UIViewController, BreedView {
    
    func startLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
                MBProgressHUD.showAdded(to: (sd.window?.rootViewController?.view)!, animated: true)
            }
        }
        else
        {
            MBProgressHUD.showAdded(to: (APPDELEGATE.window?.rootViewController?.view)!, animated: true)
        }

    }
    
    func finishLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
          
                MBProgressHUD.hide(for: (sd.window?.rootViewController?.view)!, animated: false)                       }
        }
        else
        {
            MBProgressHUD.hide(for: (APPDELEGATE.window?.rootViewController?.view)!, animated: false)                   }

    }
    
    func setBreedData(breed: [BreedInfo]) {
        
        self.arrBreedVM = breed
        DispatchQueue.main.async { () -> Void in
      
            self.finishLoading()
             self.tblBreedList?.reloadData()
            
        }
        print("update breed data",self.arrBreedVM)
    }

    
    


    @IBOutlet weak var tblBreedList  : UITableView?
    private var breedservice :BreedService!
    private var breedListViewModel :BreedListViewModel!
    var selBreedIndex : Int? = 0

    var arrBreedVM : [BreedInfo]  =  [BreedInfo] ()
    
    //MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }
    

    func commonInit() {
        
       // self.activityIndicator.isHidden = true
        self.tblBreedList?.tableFooterView = UIView()
        self.startLoading()
        self.title = "Breed List"
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
        self.breedservice = BreedService()
        self.tblBreedList?.tableFooterView = UIView()
        self.breedListViewModel = BreedListViewModel(breedservice: self.breedservice)
        self.breedListViewModel.attachView(view: self)
        }
        else
        {
            self.showAlertWithCompletion(pTitle:kAppName, pStrMessage: "Please, check your internet connection", completionBlock: nil)
        }
        
    }
    
    //MARK: IBAction Methods
    
    @IBAction func btnAscendingClicked(_ sender: UIButton)
    {

        self.breedListViewModel.sortAscending(dictBreedInfo: self.arrBreedVM)
        self.arrBreedVM = self.breedListViewModel.arrBreedsAscending ?? self.arrBreedVM
        self.tblBreedList?.reloadData()
        
        
    }
    
    @IBAction func btnDesendingClicked(_ sender: UIButton)
    {
        self.breedListViewModel.sortDescending(dictBreedInfo: self.arrBreedVM)
        self.arrBreedVM = self.breedListViewModel.arrBreedsDesending ?? self.arrBreedVM
        self.tblBreedList?.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BreedListVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBreedVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : BreedInfoCell = tableView.dequeueReusableCell(withIdentifier: "BreedInfoCell") as! BreedInfoCell
        let objBreedInfo : BreedInfo = self.arrBreedVM[indexPath.row]
        cell.setupData(objBreednfo: objBreedInfo)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selBreedIndex = indexPath.row
        self.performSegue(withIdentifier: "BreedListToDetail", sender: self)
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("prepare for segue")
        
        if (segue.identifier == "BreedListToDetail")
        {
            let objVC : BreedDetailVC = segue.destination as! BreedDetailVC
            let objItem  = self.arrBreedVM[self.selBreedIndex!]
            objVC.setBreedDetail(breed:objItem )
        }
        
    }
}
