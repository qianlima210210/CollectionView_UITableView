//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by QDHL on 2017/12/6.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
 {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array:[Dictionary<String, String>] = [["title":"One"],["title":"Two"], ["title":"Three"]]
    
    var margin:CGFloat = 0.0;
    var cellWidth: CGFloat = 0.0
    var imageWidth: CGFloat = 0.0
    let reuseCell = "reuseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configCollectionView()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMethod(recognizer:)))
        longPress.minimumPressDuration = 0.3
        collectionView.addGestureRecognizer(longPress)
        
    }
    
    @objc func longPressMethod(recognizer: UILongPressGestureRecognizer) -> Void {
        switch recognizer.state {
        case .possible:
            print("possible")
        case .began:
            print("began")
            //判断手势位置是否在cell上
            let point = recognizer.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point){
                collectionView.beginInteractiveMovementForItem(at: indexPath)
            }
            
        case .changed:
            print("changed")
            //移动过程中更新cell的位置
            let point = recognizer.location(in: collectionView)
            collectionView.updateInteractiveMovementTargetPosition(point)
        case .ended:
            print("ended")
            //移动结束后关闭cell移动
            collectionView.endInteractiveMovement()
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let count = array.count
        let item = ["title":"add \(count)"];
        array.append(item)
        
        //刷新方式一
        //collectionView.reloadData()
        
        //刷新方式二
        let indexPath: IndexPath = IndexPath(item: array.count - 1, section: 0)
        let indexPaths = [indexPath]
        collectionView.insertItems(at: indexPaths)
    }
    
    @IBAction func del(_ sender: Any) {

        array.remove(at: 0)
        
        //刷新方式一
        //collectionView.reloadData()
        
        //刷新方式二
        let indexPath: IndexPath = IndexPath(item: 0, section: 0)
        let indexPaths = [indexPath]
        collectionView.deleteItems(at: indexPaths)
        
    }
    
    func configCollectionView() -> Void {
        
        let scale = self.view.bounds.size.width / 320;
        imageWidth = scale * 60;
        
        
        margin = (self.view.bounds.size.width - imageWidth * 4) / 10
        cellWidth = (self.view.bounds.size.width - 2 * margin) / 4
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseCell)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: UICollectionViewDataSource
    @available(iOS 6.0, *)
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return array.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! MyCollectionViewCell
        cell.updateConstraint(height: imageWidth, width: imageWidth, leading: margin)
        
        let title = array[indexPath.item]["title"] ?? ""
        cell.title.text = title

        return cell
    }
    
    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool{
            return true
    }
    
    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let item = array[sourceIndexPath.item]
        array.remove(at: sourceIndexPath.item)
        array.insert(item, at: destinationIndexPath.item)
    }
    
    //MARK :UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        //行与行的间距
        return margin
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        //列与列的间距
        return 0
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: 0, height: 0)
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return CGSize(width: 0, height: 0)
    }

}

