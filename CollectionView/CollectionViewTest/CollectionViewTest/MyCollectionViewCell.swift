//
//  MyCollectionViewCell.swift
//  CollectionViewTest
//
//  Created by QDHL on 2017/12/7.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateConstraint(height:CGFloat, width:CGFloat, leading:CGFloat) -> Void {
        heightConstraint.constant = height
        widthConstraint.constant = width
        leadingConstraint.constant = leading
    }

}
