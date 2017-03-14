//
//  KDCollectCellViewModelProtocol.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/10.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import Foundation
import UIKit

protocol KDCollectionCellViewModelProtocol {
    var viewLayout: UICollectionViewLayout { get }
    
    var cellClassArray: [AnyClass] { get }
}
