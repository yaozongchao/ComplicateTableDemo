//
//  KDTableCellViewModel.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTableCellViewModel: NSObject {
    
    var bgColor: UIColor!
    
    var title: String?
    
    var rowHeight: CGFloat = 84.0

    
    static func viewModel(model: KDTableCellObject?) -> KDTableCellViewModel? {
        guard let item = model else {
            return nil
        }
        let viewModel = KDTableCellViewModel.init()
        
        viewModel.bgColor = item.bgColor ?? UIColor.gray
        viewModel.title = item.title
        return viewModel
    }
    
    public static func ==(lhs: KDTableCellViewModel, rhs: KDTableCellViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
