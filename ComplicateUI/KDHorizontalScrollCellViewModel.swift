//
//  KDCollectionCellViewModel.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDHorizontalScrollCellViewModel: NSObject {
    
    var bgColor: UIColor!
    
    var title: String?
    
    static func viewModel(model: KDCollectCellObject?) -> KDCollectionCellViewModelProtocol? {
        guard let item = model else {
            return nil
        }
        let viewModel = KDHorizontalScrollCellViewModel.init()
        
        viewModel.bgColor = item.bgColor ?? UIColor.gray
        viewModel.title = item.title
        return viewModel
    }
}

extension KDHorizontalScrollCellViewModel: KDCollectionCellViewModelProtocol {
    var viewLayout: UICollectionViewLayout {
        get {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            layout.sectionInset = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
            layout.minimumLineSpacing = 5
            layout.itemSize = CGSize(width: 91, height: 91)
            return layout
        }
    }
    
    var cellClassArray: [AnyClass] {
        get {
            var array = [AnyClass]()
            array.append(KDCollectionCell.self)
            return array
        }
    }
}
