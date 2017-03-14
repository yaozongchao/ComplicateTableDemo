//
//  KDCollectionViewTableCell.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit
import SnapKit

class KDCollectionViewTableCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerCellClass(model: KDCollectionCellViewModelProtocol?) {
        guard let innerViewModel = model else {
            return
        }
        
        for cls in innerViewModel.cellClassArray {
            self.collectionView.register(cls, forCellWithReuseIdentifier: "\(cls)")
        }
    }
    
    func bindData(model: KDCollectionCellViewModelProtocol?) {
        guard let innerViewModel = model else {
            return
        }
        self.collectionView.collectionViewLayout = innerViewModel.viewLayout
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, index: NSInteger) {
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        self.collectionView.tag = index
        self.collectionView.reloadData()
    }

}
