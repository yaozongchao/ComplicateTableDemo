//
//  KDTableViewObject.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit
import SwiftyJSON

struct KDTableViewObject {
    var collectArray = [KDCollectCellObject]()
    var tableArray = [KDTableCellObject]()
    var waterFlowArray = [KDWaterFlowObject]()
    
    static func createObject(jsonStr: String?) -> KDTableViewObject? {
        guard let innerJson = jsonStr else {
            return nil
        }
        var model = KDTableViewObject.init()
        let json = JSON.init(parseJSON: innerJson)
        let arrayTable = json["table"].arrayValue
        for tableJson in arrayTable {
            var item = KDTableCellObject.init(id: "1")
            item.bgColor = UIColor.yellow
            item.title = tableJson["title"].stringValue
            model.tableArray.append(item)
        }
        
        let arrayCollect = json["collect"].arrayValue
        for collectJson in arrayCollect {
            var item = KDCollectCellObject.init(id: "1")
            item.bgColor = UIColor.yellow
            item.title = collectJson["title"].stringValue
            model.collectArray.append(item)
        }
        
        let waterFlowCollect = json["water_flow"].arrayValue
        for waterFlowJson in waterFlowCollect {
            let item = KDWaterFlowObject.init(id: "1")
            item.bgColor = UIColor.blue
            item.title = waterFlowJson["title"].stringValue
            model.waterFlowArray.append(item)
        }
        
        return model
    }
    

}
