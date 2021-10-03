//
//  ViewController.swift
//  DarkSkyApp
//
//  Created by Keaton Brown on 10/2/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tell my function where to look for the weather data
        //
        if let url = NSURL(string:
                            "https://api.darksky.net/forecast/ae58c5fa7285b492f6a553d200018d9e/42.5917,88.4334") {
            if let data = NSData(contentsOf: url as URL){
                
                //Parse through the data
                //
                do {
                    let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)as! [String:AnyObject]
                    
                    // Temporarily store the parsed data in a dicitonary
                    //
                    let newDict = parsed
                    
                    // Print out these 3 pieces of data in the terminal window
                    //
                    print(newDict["currently"]!["temperature"] as Any)
                    print(newDict["currently"]!["summary"] as Any)
                    print(newDict["currently"]!["dewPoint"] as Any)
                    
                    self.currentTemp.text = "\(newDict["currently"]!["temperature"]!!)"
                    self.currentSummary.text = "\(newDict["currently"]!["summary"]!!)"
                    self.currentDewpoint.text = "\(newDict["currently"]!["dewPoint"]!!)"
                    
                }
                 
                
                // If you have aproblem reading the Jason data print an error
                //
                catch let error as NSError {
                    print("A Json parsing error occured, here are the details:\n \(error)")
                }
            }
        }
        
    }
    // Add the outlets to hold the data
    //
    @IBOutlet weak var currentTemp: UILabel!
    
    @IBOutlet weak var currentSummary: UILabel!
    
    @IBOutlet weak var currentDewpoint: UILabel!
    
}

