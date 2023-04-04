//
//  CollectionViewCellForCategory.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import UIKit

class CustomCellForCategory: UICollectionViewCell {

    @IBOutlet private var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    func setupCell() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        backgroundColor = .clear
        categoryLabel.font = .systemFont(ofSize: 13, weight: .regular)
        categoryLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
    }
    
    func setupSelectedCell() {
       backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
       categoryLabel.font = .systemFont(ofSize: 13, weight: .bold)
       categoryLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
       layer.borderWidth = 0
    }
    
    override func prepareForReuse() {
        setupCell()
    }
    
    func configureCell(with categoryName: String) {
        categoryLabel.text = categoryName
    }
}
