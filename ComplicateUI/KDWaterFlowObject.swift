//
//  KDWaterFlow.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/10.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDWaterFlowObject: NSObject {
    
    var title: String?
    
    var bgColor: UIColor = UIColor.blue
    
    var uid: String!
    
    init(id: String) {
        self.uid = id
    }
}
