//
//  BenefitCell.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/27.
//

import UIKit

class BenefitCell: UICollectionViewCell {
    @IBOutlet var benefitImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
//
    func configure(item: Benefit){
        benefitImage.image = UIImage(named: item.imageName)
        descriptionLabel.text =
        item.description
        titleLabel.text = item.title
    }
}
