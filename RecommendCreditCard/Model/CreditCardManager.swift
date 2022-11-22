//
//  CreditCardManager.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import Foundation
import FirebaseDatabase

struct CreditCardManager {
    var ref: DatabaseReference = Database.database().reference() //Firebase Realtime Database Root
    private var creditCard:[CreditCard] = []
    
    //CreditCard배열에 데이터 넣기
    mutating func setCreditCardData(creditCard: [CreditCard]) {
        self.creditCard = creditCard
    }
    
    //CreditCard배열의 item 갯수 가져오기
    func getCreditCardCount() -> Int {
        return creditCard.count
    }
    
    //CreditCard값 1개 가져오기
    func getOneOfCreditCard(idx: Int) -> CreditCard {
        return creditCard[idx]
    }
    
    //PromotionDetail값 1개 가져오기
    func getDetailOfOne(idx: Int) -> PromotionDetail {
        return creditCard[idx].promotionDetail
    }
    
    //Obtion1, Database의 Key를 알고 있을 때
    func setIsSelectedValue(idx: Int) {
        let id = creditCard[idx].id
        ref.child("Item\(id)/isSelected").setValue(true)
    }
    
    //Obtion2, Database의 Key를 모를 때
    func setIsSelectedValue2(idx: Int) {
        let id = creditCard[idx].id
        ref.queryOrdered(byChild: "id").queryEqual(toValue: id).observe(.value) {snapshot in
            guard let value = snapshot.value as? [String: [String: Any]],
                  let key = value.keys.first else { return }
            
            ref.child("\(key)/isSelected").setValue(true)
        }
    }
}
