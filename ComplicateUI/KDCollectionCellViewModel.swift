//
//  KDCollectionCellViewModel.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDCollectionCellViewModel: NSObject {
    
    var bgColor: UIColor!
    
    var title: String?
    
    static func viewModel(model: KDCollectCellObject?) -> KDCollectionCellViewModel? {
        guard let item = model else {
            return nil
        }
        let viewModel = KDCollectionCellViewModel.init()
        
        viewModel.bgColor = item.bgColor ?? UIColor.gray
        viewModel.title = item.title
        return viewModel
    }

}
