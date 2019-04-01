//
//  ViewController.swift
//  testObjectMapper
//
//  Created by stegowl on 05/02/18.
//  Copyright © 2018 stegowl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var responseFromTestApi:testModel?
    
    @IBOutlet var tblData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        WBApiCall()
        WBGetData()
        print(responseFromTestApi?.data[0].address ?? "")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return responseFromTestApi?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        Cell.textLabel?.text = responseFromTestApi?.data[indexPath.row].title ?? ""
        Cell.detailTextLabel?.text = responseFromTestApi?.data[indexPath.row].address ?? ""
        return Cell
        
    }
    
    func WBApiCall() {
        let url = "http://durisimomobileapps.net/djflahko/api/events"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            let dictionary = response.result.value as Any
            let Response = JSON(dictionary)
            print(Response)
            if Response != JSON.null {
                let stats = Response["status"].int
                if stats == 1 {
                    self.responseFromTestApi = testModel.init(response: Response)
                    self.tblData.reloadData()
                }
                else{
                    print(Response["msg"].string)
                }
            }
        }

    }
    
    //Get Data From API
    
//    {
//    "u_id":"123",
//    "gcm_id":"123",
//    "device":"desktop"
//    }
    
    func WBGetData() -> Void {
        
        let strURL = "http://durisimomobileapps.net/la_mega_fm_radio/api/user/register"
        
        let param = ["u_id":"123",
                     "gcm_id":"123",
                     "device":"ios"
                     ]
        print(strURL)
        print(param)
        AFWrapper.requestPOSTURL(strURL, params: param as [String : AnyObject]!, headers: nil, success: { (JSONResponse) -> Void in
            if let resData = JSONResponse.dictionaryObject {
                print(resData)
                let status = resData["status"] as! NSNumber
                if status == 1 {
                    print("successful")
                    
                }
                else{
                    print("duh!")
                    
                }
                
            }
            
        }){ (error) -> Void in
            print(error)
            self.makeToast("Error", toastMessage: error.localizedDescription as String)
            
        }
        
    }

}

