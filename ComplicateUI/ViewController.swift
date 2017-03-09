//
//  ViewController.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/7.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var cellCacheMap = Dictionary<NSString, UITableViewCell>()
    
    let animatePush = AnimateTransitionPush()

    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.register(KDTableViewCell.self, forCellReuseIdentifier: "KDTableViewCell")
        let cell = KDTableViewCell.init(style: .default, reuseIdentifier: nil)
        self.cellCacheMap["KDTableViewCell"] = cell
        view.register(KDCollectionViewTableCell.self, forCellReuseIdentifier: "KDCollectionViewTableCell")
        view.tableFooterView = UIView.init()
        view.sectionFooterHeight = CGFloat.leastNormalMagnitude
        view.estimatedRowHeight = 44
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl.init(frame: CGRect.zero)
        control.attributedTitle = NSAttributedString.init(string: "加载中")
        control.addTarget(self, action: #selector(handleRefreshControl), for: UIControlEvents.valueChanged)
        return control
    }()
    
    var viewModel: KDTableViewModel?
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.addSubview(self.refreshControl)
        
        self.view.addSubview(self.tableView)
        //在没有navigationBar的情况下，statusBar的高度不被考虑，下面的方法空出这20像素
        if (self.navigationController?.isNavigationBarHidden)! {
            self.tableView.snp.makeConstraints { (make) in
                make.top.equalTo((self.topLayoutGuide as AnyObject as! UIView).snp.bottom)
                make.leading.trailing.equalTo(self.view)
                make.bottom.equalTo((self.bottomLayoutGuide as AnyObject as! UIView).snp.top)
            }
        }
        else {
            self.tableView.snp.makeConstraints { (make) in
                make.edges.equalTo(self.view)
            }
        }
        let path = Bundle.main.path(forResource: "ORDER.JSON", ofType: nil)
        let jsonStr = try? NSString.init(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        let object = KDTableViewObject.createObject(jsonStr: jsonStr as String?)
        self.viewModel = KDTableViewModel.viewModel(model: object)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏statusBar，页面会往上串20像素
    override var prefersStatusBarHidden: Bool {
        get {
            return false
        }
    }
    
    func handleRefreshControl() {
        print("handleRefreshControl")
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let model = self.viewModel?.tableCellViewModel[indexPath.row] {
                model.title = "changed"
                model.bgColor = UIColor.red
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let innerViewModel = self.viewModel else {
            return 0
        }
        switch section {
        case 0:
            return 1
        case 1:
            return (innerViewModel.tableCellViewModel.count)
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if let cell = self.cellCacheMap["KDTableViewCell"] as? KDTableViewCell {
                cell.bindData(model: self.viewModel?.tableCellViewModel[indexPath.row])
            }
            return (self.viewModel?.tableCellViewModel[indexPath.row].rowHeight)!
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "KDCollectionViewTableCell", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "KDTableViewCell", for: indexPath)
            if let innerCell = cell as? KDTableViewCell {
                innerCell.bindData(model: self.viewModel?.tableCellViewModel[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is KDCollectionViewTableCell {
            let collectCell = cell as! KDCollectionViewTableCell
            collectCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
            let horizontalOffset = storedOffsets[indexPath.row] ?? 0
            collectCell.collectionView.setContentOffset(CGPoint(x: horizontalOffset, y: 0), animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is KDCollectionViewTableCell {
            let collectCell = cell as! KDCollectionViewTableCell
            storedOffsets[indexPath.row] = collectCell.collectionView.contentOffset.x
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let innerViewModel = self.viewModel else {
            return 0
        }
        return innerViewModel.collectionCellViewModel.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KDCollectionCell", for: indexPath)
        if let innerCell = cell as? KDCollectionCell {
            innerCell.bindData(viewModel: self.viewModel?.collectionCellViewModel[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let model = self.viewModel?.collectionCellViewModel[indexPath.row]
        let rectToView = cell?.convert((cell?.bounds)!, to: self.view)
        let viewController = KDDetailViewController.init(detail: model?.title, originRect: rectToView)
        self.animatePush.originRect = rectToView
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push {
            return self.animatePush
        }
        return nil
    }
}






