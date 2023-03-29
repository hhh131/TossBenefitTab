//
//  PointCell.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/27.
//

import UIKit

class MyPointCell: UICollectionViewCell {
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    func configure(item: MyPoint){
        iconView.image = UIImage(named: "ic_point")
        descriptionLabel.text = "내 포인트"
        pointLabel.text = "\(item.point)"
    }
    
}
