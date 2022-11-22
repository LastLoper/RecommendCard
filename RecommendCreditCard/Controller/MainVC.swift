//
//  ViewController.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import UIKit

class MainVC: UITableViewController {    

    var creditCardManager = CreditCardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView에 Cell 등록
        self.setUpTableViewCell()
        
        //Firebase의 RealTime Database에서 카드 정보 가져오기
//        creditCardManager.ref.observe(.value) { snapShot, _  in
//            guard let value = snapShot.value as? [String: [String: Any]] else { return }
//
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//
//                let creditCards = cardList.sorted(by: {
//                    $0.rank < $1.rank
//                })
//                self.creditCardManager.setCreditCardData(creditCard: creditCards)
//
//                DispatchQueue.main.async {
//                    //테이블뷰 리로드
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print("Error : \(error.localizedDescription)")
//            }
//        }
        
        //Firebase의 Firstore Database에서 카드 정보 가져오기
        creditCardManager.db.collection("creditCardList").addSnapshotListener { snapShot, error in
            guard let documents = snapShot?.documents else {
                print("Error : \(String(describing: error))")
                return
            }
            
            let creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("error : \(error.localizedDescription)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            self.creditCardManager.setCreditCardData(creditCard: creditCardList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setUpTableViewCell() {
        let nibName = UINib(nibName: "CreditCardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: Keys.CellIds.cardListCell)
    }
    
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardManager.getCreditCardCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.CellIds.cardListCell) as? CreditCardListCell
        else {
            return UITableViewCell()
        }
        
        let item = indexPath.item
        let cardInfo = creditCardManager.getOneOfCreditCard(idx: item)
        cell.prepare(cardInfo: cardInfo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.item
        let promotion = creditCardManager.getDetailOfOne(idx: item)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Keys.VCIds.detailVC) as! DetailVC
        vc.promotionDetail = promotion
        self.show(vc, sender: nil)

        //Obtion1, RealTime Database & Firestore의 Key를 알 때 데이터 삽입
//        creditCardManager.insertIsSelectedValue(idx: item)
        
        //Obtion2, RealTime Database & Firestore의 Key를 모를 때 데이터 삽입
        creditCardManager.insertIsSelectedValue2(idx: item)
    }
    
    //스와이프해서 테이블뷰 아이템 삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = indexPath.item
        
        if editingStyle == .delete {
            //Option1, RealTime Database & Firestore의 Key를 알 때 데이터 삭제
    //        creditCardManager.deleteItemAtFirebase(idx: item)

            //Option2, Database & Firestore의 Key를 모를때 데이터 삭제
            creditCardManager.deleteItemAtFirebase2(idx: item)
        }
    }
}
