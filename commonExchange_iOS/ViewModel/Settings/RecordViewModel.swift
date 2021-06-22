//
//  RecordViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/13.
//

import UIKit

class RecordViewModel {
    var model = [RecordList]()
    
    func configure(on vc: UIViewController) {
        self.model.append(RecordList(options: [
            RecordOption(recordImage: "Order", title: "訂單記錄"),
            RecordOption(recordImage: "Transaction", title: "已成交記錄")
        ]))
        self.model.append(RecordList(options: [
            RecordOption(recordImage: "Withdrawal", title: "存入記錄"),
            RecordOption(recordImage: "Deposit", title: "提領記錄"),
            RecordOption(recordImage: "InternalTransfer", title: "內部轉帳記錄")
        ]))
    }

}
