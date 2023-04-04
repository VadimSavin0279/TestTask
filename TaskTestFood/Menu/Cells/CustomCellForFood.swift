//
//  CustomCellForFood.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import UIKit
import SDWebImage

class CustomCellForFood: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var descriptionOfFoodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buyButton.layer.borderWidth = 1
        buyButton.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        buyButton.layer.cornerRadius = 6
        posterImageView.layer.cornerRadius = 14
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with viewModel: Content.Docs) {
        nameLabel.text = viewModel.name
        descriptionOfFoodLabel.text = viewModel.shortDescription
        posterImageView.sd_setImage(with: URL(string: viewModel.poster.url))
    }
}
