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


protocol reloadTable {
    //Protocol to Reload Data in MainView
    func loadTable ();
}


class JsonModel: NSObject {
    
    var tittleArray : [String] = [];
    var viewsArray : [Int] = [];
    var descriptionArray : [String] = [];
    var linkArray : [String] = [];
    var upsArray : [Int] = [];
    var scoreArray : [Int] = [];
    var downArray : [Int] = [];
    var delegate : reloadTable! = nil
    
    

    
    func restService(category: String, sort: String, showViral: Bool) -> (title:[String], description:[String]) {
        
        //Set Your Client ID Number
        let headers = ["Authorization": "Client-ID **********"]
        let baseURL = "https://api.imgur.com/3/gallery/\(category)/\(sort)/0/day/\(showViral).json"
        
        print("Base URL:  \(baseURL)")
        
        Alamofire.request(.GET, baseURL, headers: headers).responseJSON { response in
            switch response.result {
            case .Success(let data):
                
                let json = JSON(data);
                let sucess = json["success"].int;
                
                if (sucess == 1){
                    let data =  json["data"];
                    
                    //Clear All Arrays
                    self.tittleArray.removeAll();
                    self.viewsArray.removeAll();
                    self.scoreArray.removeAll();
                    self.upsArray.removeAll();
                    self.downArray.removeAll();
                    self.linkArray.removeAll();
                    self.descriptionArray.removeAll();
                    
                    
                    for i in 0..<data.count{
                        
                        //Parse Array from Json Response
                        let subArray = data[i];
                        let tittle = subArray["title"].string
                        let views = subArray["views"].int
                        let description = subArray["description"].string
                        let link_ = subArray["link"].string
                        let score = subArray["score"].int
                        let ups = subArray["ups"].int
                        let downs = subArray["downs"].int
                        
                        //Substring Https URL to Http
                        let rangeOfDomain = link_!.endIndex.advancedBy(-3)..<link_!.endIndex
                        let lastChart = link_![rangeOfDomain]
                        
                        //Check if image URL is a real image
                        if lastChart == "jpg"  || lastChart == "gif" || lastChart == "png"{
                            
                            self.tittleArray.append(tittle!);
                            self.viewsArray.append(views!);
                            self.scoreArray.append(score!);
                            self.upsArray.append(ups!);
                            self.downArray.append(downs!);
                            
                            //Change URL
                            let remplacedLink = link_?.stringByReplacingOccurrencesOfString("http", withString: "https");
                            
                            self.linkArray.append(remplacedLink!)
                            
                            if description == nil{
                                self.descriptionArray.append("Description");
                            }
                            else{
                                self.descriptionArray.append(description!)
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    // Reload Data
                    
                self.delegate.loadTable()
                    
                    
                    
                }else{
                    print ("Error to Access");
                    
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
      
    
       
        return (self.tittleArray, self.descriptionArray);
        
        
        
        
    }
    


}
