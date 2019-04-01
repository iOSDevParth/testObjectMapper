//
//  testAPI.swift
//  testObjectMapper
//
//  Created by stegowl on 05/02/18.
//  Copyright © 2018 stegowl. All rights reserved.
//

import Foundation
import SwiftyJSON

class testModel {
    var status:Int?
    var msg:String?
    var data:[Events]!
    
    init(response : JSON) {
        let dataArray = response["data"].arrayValue
        
        self.data = dataArray.map { Events.init(data: $0)}
    }
    
}

class Events {
    var event_id:Int?
    var title:String?
    var description:String?
    var start:String?
    var end:String?
    var time:String?
    var latitude:String?
    var longitude:String?
    var address:String?
    var image:String?
    
    init(data : JSON) {
        self.event_id = data["event_id"].int
        self.title = data["title"].string
        self.description = data["description"].string
        self.start = data["start"].string
        self.end = data["end"].string
        self.time = data["time"].string
        self.latitude = data["latitude"].string
        self.longitude = data["longitude"].string
        self.address = data["address"].string
        self.image = data["image"].string
    }
}
