//
//  ViewController.swift
//  swiftImgur_CustomGallery
//
//  Created by Oswaldo Morales on 31/05/16.
//  Copyright © 2016 Oswaldo Morales. All rights reserved.
//

import UIKit

protocol DestinationViewDelegate {
  
    //Sort Protocol
    func sortView (sort: String, showViral_1: Bool, category: String);
    
}


class filter_controller: UIViewController {
    
    let URL_BASE = "https://api.imgur.com/3/gallery/top/"
    var sort = "viral"
     var delegate : DestinationViewDelegate! = nil

    //Outlets Fromo Dialog Controller
    @IBOutlet weak var viralBTN: UIButton!
    @IBOutlet weak var userBTN: UIButton!
    @IBOutlet weak var topBTN: UIButton!
    @IBOutlet weak var switchViral: UISwitch!
    
    var container: ViewController?
    var viralBol: Bool!
    var category_1: String!
    let  textColor = UIColor.cyanColor();
    
    
    
    
    @IBAction func viral(sender: AnyObject) {
        
        sort = "viral"
    
        //Set Color to Buttons
        viralBTN.setTitleColor(textColor, forState: .Normal)
        userBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
        topBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func top(sender: AnyObject) {
        
        sort = "top"
        
         //Set Color to Buttons
        viralBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
        userBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
        topBTN.setTitleColor(textColor, forState: .Normal)
    
    }

    @IBAction func user(sender: AnyObject) {
        
        sort = "user"
        
         //Set Color to Buttons
        viralBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
        userBTN.setTitleColor(textColor, forState: .Normal)
        topBTN.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func aceptACT(sender: AnyObject) {
        
        
        if switchViral.on {
            viralBol = true;
        }
        else{
            viralBol = false;
            
        }
   
    
        self.dismissViewControllerAnimated(true, completion: nil);
        //Asig Protocol Function
        delegate.sortView(sort, showViral_1: viralBol, category: category_1)
        
    
    }
    
  

    @IBAction func cancelACT(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
        
        
    }
}
