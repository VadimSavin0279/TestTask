//
//  CustomCellForStock.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import UIKit

class CustomCellForStock: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        clipsToBounds = true
    }

}
