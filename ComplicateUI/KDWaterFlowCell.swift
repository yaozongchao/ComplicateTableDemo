//
//  KDWaterFlowCell.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/14.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDWaterFlowCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.edges.equalTo(self.contentView).inset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(viewModel: KDWaterFlowCellViewModel?) {
        guard let innerViewModel = viewModel else {
            return
        }
        self.titleLabel.text = innerViewModel.title
        self.contentView.backgroundColor = innerViewModel.bgColor
    }
}
