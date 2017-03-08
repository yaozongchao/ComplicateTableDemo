//
//  KDTableViewCell.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTableViewCell: UITableViewCell {
        
    fileprivate var viewModel: KDTableCellViewModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = self.bounds.width
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindData(model: KDTableCellViewModel?) {
        guard let innerViewModel = model else {
            return
        }
        self.titleLabel.text = innerViewModel.title
        self.contentView.backgroundColor = innerViewModel.bgColor
        if innerViewModel != self.viewModel {
            self.contentView.setNeedsLayout()
            self.contentView.layoutIfNeeded()
            innerViewModel.rowHeight = self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height + 1.0
            self.viewModel = innerViewModel
        }
    }

}
