//
//  CreditCardManager.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore

struct CreditCardManager {
    var ref: DatabaseReference = Database.database().reference() //Firebase Realtime Database Root
    var db = Firestore.firestore()
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
    
    //데이터 삽입 -
    func insertIsSelectedValue(idx: Int) {
        let id = creditCard[idx].id
        
        //Obtion1, Database의 Key를 알고 있을 때 : RealTime Database
//        ref.child("Item\(id)/isSelected").setValue(true)
        
        //Obtion1, Database의 Key를 알고 있을 때 : RealTime Database
        db.collection("creditCardList").document("card\(id)").updateData(["isSelected":true])
    }
    
    //데이터 삽입 -
    func insertIsSelectedValue2(idx: Int) {
        let id = creditCard[idx].id
        
        //Option2, Database의 Key를 모를 때 : RealTime Database
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: id).observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else { return }
//
//            ref.child("\(key)/isSelected").setValue(true)
//        }
        
        //Option2, Database의 Key를 모를 때 : RealTime Database
        db.collection("creditCardList").whereField("id", isEqualTo: id).getDocuments { snapShot, _ in
            guard let document = snapShot?.documents.first else {
                print("error while fetching document at Firestore")
                return
            }
            
            document.reference.updateData(["isSelected": true])
        }
    }
    
    //데이터 삭제 -
    func deleteItemAtFirebase(idx: Int) {
        let id = creditCard[idx].id
        
        //Option1, Key를 알고 있을 때
        //RealTime
//        ref.child("Item\(id)/isSelected").removeValue()
        
        //Firestore
        db.collection("creditCardList").document("card\(id)").delete()
    }
    
    //데이터 삭제 -
    func deleteItemAtFirebase2(idx: Int) {
        let id = creditCard[idx].id
        
        //Option2, Key를 모를때
        //RealTime
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: id).observe(.value) { snapShot in
//            guard let value = snapShot.value as? [String: [String: Any]],
//                  let key = value.keys.first else { return }
//            
//            ref.child(key).removeValue()
//        }
        
        //Firestore
        db.collection("creditCardList").whereField("id", isEqualTo: id).getDocuments { snapShot, _ in
            guard let document = snapShot?.documents.first else {
                print("error while fetching document at Firestore")
                return
            }
            
            document.reference.delete()
        }
    }
}
