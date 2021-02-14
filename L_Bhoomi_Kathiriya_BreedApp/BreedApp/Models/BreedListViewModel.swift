//
//  BreedListViewModel.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class BreedListViewModel: NSObject {
    
    
    private var breedService : BreedService
    var arrBreedsAscending : [BreedInfo]? = []
    var arrBreedsDesending : [BreedInfo]? = []
    var arrBreeds : [BreedInfo]? = []
    var breedView : BreedView?
    func attachView(view: BreedView) {
        breedView = view
    }
    
    func detachView() {
        breedView = nil
    }
    init(breedservice :BreedService) {
        
        self.breedService = breedservice
        super.init()
        populateSources()
    }
    
    func populateSources() {
        
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
            self.breedView?.startLoading()
            let strURL = String(format: "%@%@",kBaseURL)
            print("breed info url",strURL)
            BreedService.getWebServiceCall(kBaseURL, headerPrm: nil, isShowLoader: true, success: { (response) in
                let data = response.data
                // your failure handle
                
                print("web servie output is",response)
                do
                {
                    var dictBreedInfo : BreedInfoAlias!
                    let decoder = JSONDecoder()
                    dictBreedInfo = try decoder.decode(BreedInfoAlias.self, from: data!)
                    print("codable dict is",dictBreedInfo)
                    
                    var index : Int = 0
                    for var objBreedInfo in dictBreedInfo
                    {
                        if(objBreedInfo.breeds?.count ?? 0 > 0)
                        {
                            
                            let objBreedInfoDetail :  Breed? = objBreedInfo.breeds?[0]
                            let arrTemp = objBreedInfoDetail?.lifeSpan?.components(separatedBy: " ")
                            if(arrTemp?.count ?? 0 > 2)
                            {
                                
                                let endLifeSpan = Int(arrTemp?[2] ?? "")
                                objBreedInfo.strLifeSpan = endLifeSpan
                                
                            }
                            else
                            {
                                
                                if(arrTemp?.count ?? 0 > 0)
                                {
                                    
                                    let stLifeSpan = Int(arrTemp?[0] ?? "")
                                    objBreedInfo.strLifeSpan = stLifeSpan
                                }

                            }
                            
                            self.arrBreeds?.append(objBreedInfo)
                            index = index + 1
                            
                        }
                        
                    }
                    
                    
                    print("arr breed is",self.arrBreeds)
                    let sortedArray1 = self.arrBreeds?.sorted {
                        $0.strLifeSpan ?? 0 < $1.strLifeSpan ?? 0
                    }
                    
                    self.breedView?.setBreedData(breed: sortedArray1!)
                    DispatchQueue.main.async { () -> Void in
                        
                        self.breedView?.finishLoading()
                    }
                }
                catch
                {
                    DispatchQueue.main.async { () -> Void in
                        self.breedView?.finishLoading()
                    }
                    print("exception occured while parsing data",error.localizedDescription)
                }
                
                
            }){ (ERROR) in
                DispatchQueue.main.async { () -> Void in
                    
                    self.breedView?.finishLoading()
                }
                print(ERROR.localizedDescription)
            }
            
        }
        else
        {
            //  self.displayNoInternetAlert()
            //return
            
        }
    }
    
    func sortAscending(dictBreedInfo:[BreedInfo])
    {
        
        let sortedArray = arrBreeds?.sorted {
            $0.strLifeSpan ?? 0 < $1.strLifeSpan ?? 0
        }
        self.arrBreedsAscending = sortedArray
       // print("sorted array  ascending is",arrBreedsAscending)
        
        
    }
    
    
    func sortDescending(dictBreedInfo:[BreedInfo])
    {
        
        let sortedArray = arrBreeds?.sorted {
            $0.strLifeSpan ?? 0 > $1.strLifeSpan ?? 0
        }
        self.arrBreedsDesending = sortedArray
       // print("sorted array  descending is",arrBreedsDesending)
        
    }
    
    
}


