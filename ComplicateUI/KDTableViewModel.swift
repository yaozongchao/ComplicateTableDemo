//
//  KDTableViewModel.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTableViewModel: NSObject {
    var tableCellViewModel = [KDTableCellViewModel]()
    var collectionCellViewModel = [KDCollectionCellViewModelProtocol]()
    var waterFlowCellViewModel = [KDCollectionCellViewModelProtocol]()

    
    static func viewModel(model: KDTableViewObject?) -> KDTableViewModel? {
        guard let innerModel = model else {
            return nil
        }
        let viewModel = KDTableViewModel.init()
        for (_, element) in innerModel.tableArray.enumerated() {
            if let item = KDTableCellViewModel.viewModel(model: element) {
                viewModel.tableCellViewModel.append(item)
            }
        }
        
        for (_, element) in innerModel.collectArray.enumerated() {
            if let item = KDHorizontalScrollCellViewModel.viewModel(model: element) {
                viewModel.collectionCellViewModel.append(item)
            }
        }
        
        for (_, element) in innerModel.waterFlowArray.enumerated() {
            if let item = KDWaterFlowCellViewModel.viewModel(model: element) {
                viewModel.waterFlowCellViewModel.append(item)
            }
        }

        return viewModel
    }

}
