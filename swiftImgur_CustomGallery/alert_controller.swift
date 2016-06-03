//
//  ViewController.swift
//  swiftImgur_CustomGallery
//
//  Created by Oswaldo Morales on 31/05/16.
//  Copyright © 2016 Oswaldo Morales. All rights reserved.
//

import UIKit

class alert_controller: UIViewController {
    
    @IBOutlet weak var title_1: UILabel!
    @IBOutlet weak var descripText: UITextView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var viewsText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var upsText: UILabel!
    @IBOutlet weak var downsText: UILabel!
    
    var titleString:String!
    var descriptionString:String!
    var urlString:String!
    var viewsInt: Int!
    var scoreInt:Int!
    var upsInt:Int!
    var downsInt:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Variables From Json Object
        title_1.text = titleString;
        descripText.text = descriptionString;
        scoreText.text = String(scoreInt);
        upsText.text = String(upsInt);
        downsText.text = String(downsInt);
        viewsText.text = String(viewsInt);
        
        alertImage.sd_setImageWithURL(NSURL(string: urlString)!, placeholderImage: nil)
        
       
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
     
    }

}
