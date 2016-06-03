//
//  ViewController.swift
//  swiftImgur_CustomGallery
//
//  Created by Oswaldo Morales on 31/05/16.
//  Copyright © 2016 Oswaldo Morales. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var views_1: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
