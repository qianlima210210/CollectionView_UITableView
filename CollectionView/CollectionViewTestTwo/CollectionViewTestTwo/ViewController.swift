//
//  ViewController.swift
//  CollectionViewTestTwo
//
//  Created by QDHL on 2017/12/8.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
    var maskCell: TestCell?
    //正在拖拽的indexpath
    var sourceIndexPath: IndexPath?
    //目标位置
    var targetIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.buildUI()
    }

    func buildUI() -> Void {
        let margin: CGFloat = 10.0
        let columnNumber: CGFloat = 4.0    //任何设备都是4列，margin不变，变得是cell宽度
        let cellWidth = (self.view.bounds.size.width - (columnNumber + 1) * margin) / columnNumber
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: margin, right: margin)
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 50)
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: "TestCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "TestCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        view.addSubview(collectionView!)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longPress.minimumPressDuration = 0.3
        collectionView?.addGestureRecognizer(longPress)
        
        maskCell = Bundle.main.loadNibNamed("TestCell", owner: nil, options: nil)?.last as? TestCell
        maskCell?.backgroundColor = UIColor.red
        
        maskCell?.isHidden = true
        collectionView?.addSubview(maskCell!)
    }

    @objc func longPress(recognizer: UILongPressGestureRecognizer) -> Void {
        switch recognizer.state {
        case .began:
            self.dragBegin(recognizer: recognizer)
        case .changed:
            self.dragChanged(recognizer: recognizer)
        case .ended:
            self.dragEnd(recognizer: recognizer)
        default:
            break
        }
    }
    
    func dragBegin(recognizer: UILongPressGestureRecognizer) -> Void {
        //获取指定坐标系的触摸位置
        let point = recognizer .location(in: collectionView)
        //获取point对应cell的indexPath
        sourceIndexPath = collectionView?.indexPathForItem(at: point)
        if sourceIndexPath == nil {
            return
        }
        let sourceCell = collectionView?.cellForItem(at: sourceIndexPath!) as? TestCell
        sourceCell?.isHidden = true
        
        collectionView?.bringSubview(toFront: maskCell!)
        maskCell?.frame = sourceCell?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        maskCell?.titleLab.text = sourceCell?.titleLab.text
        maskCell?.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.maskCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }) { (finish: Bool) in
            
        }
    }

    
    func dragChanged(recognizer: UILongPressGestureRecognizer) -> Void {
        //让dragingCell随着手指移动
        let point = recognizer.location(in: collectionView)
        maskCell?.center = point
        //获取point对应cell的indexPath
        targetIndexPath = collectionView?.indexPathForItem(at: point)
        
        if sourceIndexPath != nil && targetIndexPath != nil{
            collectionView?.moveItem(at: sourceIndexPath!, to: targetIndexPath!)
            sourceIndexPath = targetIndexPath
        }
    }
    
    func dragEnd(recognizer: UILongPressGestureRecognizer) -> Void {
        
        if sourceIndexPath == nil {
            return
        }
        let sourceCell = collectionView?.cellForItem(at: sourceIndexPath!) as? TestCell
        sourceCell?.isHidden = false
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.maskCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (finish: Bool) in
            
            self.maskCell?.isHidden = true
            self.collectionView?.sendSubview(toBack: self.maskCell!)
        }
    }
    
    
    //MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 50
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLab.text = "\(indexPath.item)"
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool{
        return true
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){

    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    

    
    
    
    
    
    
    
}











