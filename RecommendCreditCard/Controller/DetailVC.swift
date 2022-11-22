//
//  DetailVC.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import UIKit
import Lottie

class DetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    var promotionDetail: PromotionDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = LottieAnimationView(name: "money")
        self.lottieView.contentMode = .scaleAspectFit
        self.lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        
        self.titleLabel.text = """
        \(detail.companyName)카드를 사용하면,
        \(detail.amount)만원을 드려요
        """
        self.periodLabel.text = detail.period
        self.conditionLabel.text = detail.condition
        self.benefitConditionLabel.text = detail.benefitCondition
        self.benefitDetailLabel.text = detail.benefitDetail
        self.benefitDateLabel.text = detail.benefitDate
    }
}
