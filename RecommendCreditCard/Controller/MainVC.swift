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
        
        //Firebase의 Database에서 카드 정보 가져오기
        creditCardManager.ref.observe(.value) { snapShot, _  in
            guard let value = snapShot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                
                let creditCards = cardList.sorted(by: {
                    $0.rank < $1.rank
                })
                self.creditCardManager.setCreditCardData(creditCard: creditCards)
                
                DispatchQueue.main.async {
                    //테이블뷰 리로드
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error : \(error.localizedDescription)")
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

        //Obtion1, Database의 Key를 알 때
//        creditCardManager.setIsSelectedValue(idx: item)
        
        //Obtion2, Database의 Key를 모를 때
        creditCardManager.setIsSelectedValue2(idx: item)
    }
    
    //스와이프해서 테이블뷰 아이템 삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
}
