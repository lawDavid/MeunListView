//
//  MeunListSelectionCell.swift
//  testNavigation
//
//  Created by DavidLaw on 2018/4/11.
//  Copyright © 2018年 DavidLaw. All rights reserved.
//

import UIKit

class MeunListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    var model: MeunListModel? {
        didSet {
            titleLabel.text = model?.title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedImageView.isHidden = false
                titleLabel.textColor = UIColor(red:0.1, green:0.58, blue:0.94, alpha:1)
            }
            else {
                selectedImageView.isHidden = true
                titleLabel.textColor = UIColor(red:0.3, green:0.3, blue:0.3, alpha:1)
            }
        }
    }
}
