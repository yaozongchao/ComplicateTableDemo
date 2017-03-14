//
//  KDWaterFlowLayout.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/14.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

protocol KDWaterFlowLayoutDelegate: class {
    func heightForRow(flowLayout: KDWaterFlowLayout, index: Int, itemWidth: CGFloat) -> CGFloat
    
    func columnCount(flowLayout: KDWaterFlowLayout) -> Int
    func columnMargin(flowLayout: KDWaterFlowLayout) -> CGFloat
    func rowMargin(flowLayout: KDWaterFlowLayout) -> CGFloat
    
    func edgeInsets(flowLayout: KDWaterFlowLayout) -> UIEdgeInsets
}

class KDWaterFlowLayout: UICollectionViewLayout {
    
    static let defaultColumnCount: Int = 3
    static let defaultColumnMargin: CGFloat = 10
    static let defaultRowMargin: CGFloat = 10
    static let defaultEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    
    var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var columnHeights: [CGFloat] = [CGFloat]()
    var contentHeight: CGFloat = 0
    
    weak var delegate: KDWaterFlowLayoutDelegate?
    
    var rowMargin: CGFloat {
        get {
            if let delegate = self.delegate {
                return delegate.rowMargin(flowLayout: self)
            }
            return KDWaterFlowLayout.defaultRowMargin
        }
    }
    
    var columnMargin: CGFloat {
        get {
            if let delegate = self.delegate {
                return delegate.columnMargin(flowLayout: self)
            }
            return KDWaterFlowLayout.defaultColumnMargin
        }
    }
    
    var columnCount: Int {
        get {
            if let delegate = self.delegate {
                return delegate.columnCount(flowLayout: self)
            }
            return KDWaterFlowLayout.defaultColumnCount
        }
    }
    
    var edgeInsets: UIEdgeInsets {
        get {
            if let delegate = self.delegate {
                return delegate.edgeInsets(flowLayout: self)
            }
            return KDWaterFlowLayout.defaultEdgeInsets
        }
    }
    
    override func prepare() {
        super.prepare()
        self.contentHeight = 0
        self.columnHeights.removeAll()
        for _ in 0..<self.columnCount {
            self.columnHeights.append(self.edgeInsets.top)
        }
        
        self.attrsArray.removeAll()
        if let count = self.collectionView?.numberOfItems(inSection: 0) {
            for i in 0..<count {
                let indexPath = IndexPath.init(item: i, section: 0)
                let attrs = self.layoutAttributesForItem(at: indexPath)
                self.attrsArray.append(attrs!)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionViewWidth = self.collectionView?.frame.width
        let part1 = CGFloat(self.columnCount - 1)*self.columnMargin
        let molecular = collectionViewWidth! - self.edgeInsets.left - self.edgeInsets.right - part1
        let width = molecular / CGFloat(self.columnCount)
        let height = self.delegate?.heightForRow(flowLayout: self, index: indexPath.item, itemWidth: width)
        
        var destColumn = 0
        var minColumnHeight = self.columnHeights[0]
        for i in 0..<self.columnCount {
            let columnHeight = self.columnHeights[i]
            if columnHeight < minColumnHeight {
                minColumnHeight = columnHeight
                destColumn = i
            }
        }
        
        let x = self.edgeInsets.left + CGFloat(destColumn)*(width + self.columnMargin)
        var y = minColumnHeight
        if y != self.edgeInsets.top {
            y += self.rowMargin
        }
        
        attrs.frame = CGRect.init(x: x, y: y, width: width, height: height!)
        
        self.columnHeights[destColumn] = attrs.frame.maxY
        
        let columnHeight = self.columnHeights[destColumn]
        if self.contentHeight < columnHeight {
            self.contentHeight = columnHeight
        }
        
        return attrs
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize.init(width: 0, height: self.contentHeight + self.edgeInsets.bottom)
        }
    }

}
