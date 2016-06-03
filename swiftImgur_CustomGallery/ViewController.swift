//
//  ViewController.swift
//  swiftImgur_CustomGallery
//
//  Created by Oswaldo Morales on 31/05/16.
//  Copyright © 2016 Oswaldo Morales. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, DestinationViewDelegate, reloadTable{
   
    var tittleArray : [String] = [];
    var viewsArray : [Int] = [];
    var descriptionArray : [String] = [];
    var linkArray : [String] = [];
    var upsArray : [Int] = [];
    var scoreArray : [Int] = [];
    var downArray : [Int] = [];
    
    var hideFlag : Bool = true;
    var category: String = "top";
    
    let  instance = JsonModel();
    


    
    //Outlets ViewController
    @IBOutlet weak var mainGridView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var hotBTN: UIButton!
    @IBOutlet weak var topBTN: UIButton!
    @IBOutlet weak var userBTN: UIButton!
    @IBOutlet weak var listBTN: UIButton!
    
    let  textColor = UIColor.cyanColor();
    
//MARK: Init Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Size of Main TableView
        self.mainTableView.rowHeight = 100.0;
    
        //Set Delegates and Data source
        self.mainTableView.dataSource = self;
        self.mainTableView.delegate = self;
        self.mainGridView.dataSource = self;
        self.mainGridView.delegate = self;
        

    
        instance.restService(category, sort: "viral", showViral: true);
        instance.delegate = self;
        
        //modalPresentationCapturesStatusBarAppearance
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }


  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    //MARK: Navigation links
    @IBAction func userAct(sender: AnyObject) {
        
        category = "user"
        
        //Asign Colors to Buttons
        instance.restService(category, sort: "viral", showViral: true)
        topBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        hotBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        userBTN.setTitleColor(textColor, forState: .Normal)
    }
    
    @IBAction func topAct(sender: AnyObject){
       
        category = "top"
         //Asign Colors to Buttons
        instance.restService(category, sort: "viral", showViral:  true)
        topBTN.setTitleColor(textColor, forState: .Normal)
        hotBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        userBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        
    }
    
    @IBAction func hotAct(sender: AnyObject) {
        
        category = "hot"
         //Asign Colors to Buttons
        instance.restService(category, sort: "viral", showViral: true)
        topBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        hotBTN.setTitleColor(textColor, forState: .Normal)
        userBTN.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
    }
    
    //MARK: Dialog Alerts
    @IBAction func filterAlert(sender: AnyObject) {
     let vc = self.storyboard?.instantiateViewControllerWithIdentifier("filter") as! filter_controller
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.delegate = self //Delrgate Protocol
        vc.category_1 = category
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
       
        
    }
    
    @IBAction func aboutAlert(sender: AnyObject) {
    
    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("about") as! about_controller
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    
    
    }
    
    //MARK: TableView Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tittleArray.count;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
    // Set Detail View Controler Variables
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("alert") as!  alert_controller
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        vc.titleString = tittleArray[indexPath.row];
        vc.descriptionString = descriptionArray[indexPath.row];
        vc.urlString = linkArray[indexPath.row];
        vc.viewsInt = viewsArray[indexPath.row];
        vc.scoreInt = scoreArray[indexPath.row];
        vc.upsInt = upsArray[indexPath.row];
        vc.downsInt = downArray[indexPath.row];
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    
        
    }
   
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! BasicCell
        
    
        let row = indexPath.row
        cell.name.text =  tittleArray[row];
        cell.views_1.text = String(viewsArray[row]);
        cell.Description.text = String(descriptionArray[row]);
        cell.imageCell.sd_setImageWithURL(NSURL(string: linkArray [row])!, placeholderImage: UIImage(named: "progress_icn.png"))
    
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0;
    }
  
    
    
    @IBAction func reloadData(sender: AnyObject) {
        
        if hideFlag == true {
            self.mainTableView.hidden = true
            hideFlag = false
            listBTN.setImage(UIImage(named: "list_icn.png"), forState: .Normal)
            
        }
        else {
            self.mainTableView.hidden = false;
            hideFlag = true
            listBTN.setImage(UIImage(named: "biggrid_icn.png"), forState: .Normal)
        }
        
    
    }
    
    
    //MARK: Grid View Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tittleArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RowCell", forIndexPath: indexPath) as! BasicRow
        
        let row = indexPath.row
        cell.rowTitle.text = tittleArray[row];
        cell.rowImage.sd_setImageWithURL(NSURL(string: linkArray [row])!, placeholderImage: UIImage(named: "progress_icn.png"))
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        // Set Detail View Controler Variables
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("alert") as!  alert_controller
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        vc.titleString = tittleArray[indexPath.row];
        vc.descriptionString = descriptionArray[indexPath.row];
        vc.urlString = linkArray[indexPath.row];
        vc.viewsInt = viewsArray[indexPath.row];
        vc.scoreInt = scoreArray[indexPath.row];
        vc.upsInt = upsArray[indexPath.row];
        vc.downsInt = downArray[indexPath.row];
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    //Use for interspacing
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    
  
  
    //MARK: Protocols Call Backs
    
    func sortView (sort: String, showViral_1: Bool, category: String){
         print("test\(sort)");
        //restService("user", sort: sort, showViral: showViral_1 );
        instance.restService(category, sort: sort, showViral: showViral_1 );
    }
    
    func loadTable (){
        
        //Load Table Protocol
        tittleArray = instance.tittleArray;
        viewsArray = instance.viewsArray;
        descriptionArray = instance.descriptionArray;
        linkArray = instance.linkArray;
        scoreArray = instance.scoreArray;
        upsArray = instance.upsArray;
        downArray = instance.downArray;
        
        self.mainTableView.reloadData();
        self.mainGridView.reloadData();
    }

}


