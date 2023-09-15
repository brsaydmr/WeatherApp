//
//  SonucVC.swift
//  Hava Durumu
//
//  Created by Barış Aydemir on 28.08.2023.
//

import UIKit

class SonucVC: UIViewController {

    @IBOutlet weak var sehirAdLabel: UILabel!
    @IBOutlet weak var dereceLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sehirAdLabel.text = city
        getTodayResult(cityName: city)

    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func getTodayResult(cityName: String) {
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef") {
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    if let incomingData = data {
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            //print(json)
                            
                            if let main = json["main"] as? NSDictionary {
                                
                                if let temp = main["temp"] as? Double {
                                   
                                    let state = Int(temp - 273.15)
                                    let humidity = main["humidity"] as? Int
                                    DispatchQueue.main.sync {
                                        self.dereceLabel.text = String("\(state) °C")
                                        self.humidityLabel.text = String("Nem %\(humidity!)")
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                }
                
            }
            task.resume()
            
        }
        
        
    }
    

}
