//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Pankti Chokshi on 04/23/2019.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate=self
        currencyPicker.dataSource=self
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL=baseURL+currencyArray[row]
        print(finalURL)
        getBitcoinPriceData(url:finalURL)
    }
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinPriceData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Bitcoin data")
                    let bitcoinJSON : JSON = JSON(response.result.value)

                    self.updateBitcoinPriceData(json: bitcoinJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

//
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinPriceData(json : JSON) {
        
        if let priceResult = json["bid"].double {
            bitcoinPriceLabel.text="\(priceResult)"
        }
        
        else{
            bitcoinPriceLabel.text="Data Unavailable"
        }
    }

}

