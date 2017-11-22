//
//  ViewController.swift
//  ProgressMeter
//
//  Created by khawajafarooq on 11/22/2017.
//  Copyright (c) 2017 khawajafarooq. All rights reserved.
//

import UIKit
import ProgressMeter

class ViewController: UIViewController {

    @IBOutlet weak var progressControl: ProgressMeter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupWithControlData()
        visualSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Setting up the control with custom data array
     provide following
     maxValue: maximum value of the meter
     data: annotation data to display
     progress: current progress of meter
     */
    func setupWithCustomData() {
        progressControl.maxValue = 20000
        progressControl.data = [1999, 4999, 9999, 14999]
        progressControl.progress = 14999 / 20000
    }
    
    /*
     Don't know the data? No problem
     provide following
     maxValue: maximum value of the meter
     numberOfDivisions: how many divisions you want to display
     progress: current progress of meter
     */
    func setupWithControlData() {
        progressControl.maxValue = 20000
        progressControl.numberOfDivisions = 4
        progressControl.progress = 0.4
    }
    
    // visually setup the control should be self explanatory
    func visualSetup() {
        progressControl.progressTintColor = UIColor(appColor: .blue)
        progressControl.trackTintColor = UIColor(appColor: .gray)
        progressControl.borderWidth = 1
        progressControl.borderColor = UIColor(appColor: .graySeparator)
        progressControl.annotationTextColor = UIColor(appColor: .blue)
        progressControl.dividerColor = UIColor(appColor: .graySeparator)
    }

}

