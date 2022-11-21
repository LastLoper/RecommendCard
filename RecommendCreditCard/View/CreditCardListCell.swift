//
//  CreditCardListCell.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import UIKit

class CreditCardListCell: UITableViewCell {

    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var lankLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
