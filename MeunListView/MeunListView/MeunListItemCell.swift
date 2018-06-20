//
//  MeunListItemCell.swift
//  testNavigation
//
//  Created by DavidLaw on 2018/4/11.
//  Copyright © 2018年 DavidLaw. All rights reserved.
//

import UIKit

class MeunListItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    var model: MeunListModel? {
        didSet {
            titleLabel.text = model?.title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                indicatorImageView.image = UIImage(named: "meunListView_arrow_up")
            }
            else {
                indicatorImageView.image = UIImage(named: "meunListView_arrow_down")
            }
        }
    }
}
