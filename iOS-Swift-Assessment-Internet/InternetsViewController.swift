//
//  InternetViewController.swift
//  iOS-Week8-Swift-Assessment
//
//  Created by Flatiron School on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class InternetsViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    let key = "b5effff115444a95919d21e60bb81154"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func updateWeatherTouched(_ sender: UIButton) {
        
        fetchWeather { (temp) in
            
            OperationQueue.main.addOperation({
                let tempString = String(describing: temp)
                self.weatherLabel.text = tempString
            })
            
            
        }
        
    }
    
    /* response from API:
    {  
        "temperature": {
            celsius = 22;
            fahrenheit = 71; 
        },
        "address": "11 Broadway, New York, NY 10004",
        "name": "Flatiron School"
    }
    */
 
    func fetchWeather(completion: @escaping (CGFloat)->()){
        
        let urlString = "https://api.darksky.net/forecast/\(key)/42.3601,-71.0589"
        
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            do
            {
                guard let unwrappedData = data else {return}
                let weather = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? NSDictionary
                
                if let weatherDictionary = weather
                {
                    let weatherArray = weatherDictionary["currently"] as! NSDictionary
                
                   // print(weatherArray)
                    
                    let temperature = weatherArray["temperature"] as! CGFloat
                    
                    print(temperature)
                    completion(temperature)
                }
                
            }
            catch{
                print(error)
            }
        }
        task.resume()

    }
}
