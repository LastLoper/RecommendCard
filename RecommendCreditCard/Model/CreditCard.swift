//
//  CreditCard.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import Foundation

struct CredigCard: Codable {
    let id: Int
    let lank: Int
    let name: String
    let cardImgUrl: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let companyName: String
    let period: String
    let amount: Int
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String
}
