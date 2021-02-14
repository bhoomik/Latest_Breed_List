//
//  BreedView.swift
//  BreedApp
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//
import Foundation
import UIKit


protocol BreedView{
     func startLoading()
	 func finishLoading()
     func setBreedData(breed: [BreedInfo])
}
