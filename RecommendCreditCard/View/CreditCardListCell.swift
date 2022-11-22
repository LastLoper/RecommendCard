//
//  CreditCardListCell.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import UIKit
import Kingfisher

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
    
    func prepare(cardInfo: CreditCard) {
        let cardName = cardInfo.name
        let lank = cardInfo.rank
        let cardImgUrl = URL(string: cardInfo.cardImageURL)
        let promotion = cardInfo.promotionDetail.amount
        
        self.cardNameLabel.text = cardName
        self.lankLabel.text = "\(lank)위"
        self.cardImgView.kf.setImage(with: cardImgUrl)
        self.promotionLabel.text = "\(promotion)만원 증정"
    }
}
