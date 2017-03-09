//
//  KDDetailViewController.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/9.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDDetailViewController: UIViewController {
    
    var originRect: CGRect?
    
    let animatePop = AnimateTransitionPop()
    
    lazy var textLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    
    var detail: String?
    
    convenience init(detail: String?, originRect: CGRect?) {
        self.init()
        self.detail = detail
        self.originRect = originRect
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        self.textLabel.text = self.detail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension KDDetailViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.pop {
            self.animatePop.originRect = self.originRect
            return self.animatePop
        }
        return nil
    }
}

