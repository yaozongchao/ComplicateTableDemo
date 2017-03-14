//
//  KDWaterFlowCellViewModel.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/10.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDWaterFlowCellViewModel: NSObject {
    var bgColor: UIColor!
    
    var title: String?
    
    static func viewModel(model: KDWaterFlowObject?) -> KDCollectionCellViewModelProtocol? {
        guard let item = model else {
            return nil
        }
        let viewModel = KDWaterFlowCellViewModel.init()
        
        viewModel.bgColor = item.bgColor 
        viewModel.title = item.title
        return viewModel
    }
    
}

extension KDWaterFlowCellViewModel: KDCollectionCellViewModelProtocol {
    var viewLayout: UICollectionViewLayout {
        get {
            let layout = KDWaterFlowLayout()
            return layout
        }
    }
    
    var cellClassArray: [AnyClass] {
        get {
            var array = [AnyClass]()
            array.append(KDWaterFlowCell.self)
            return array
        }
    }
}
