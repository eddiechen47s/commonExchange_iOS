//
//  UserAClass.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import Foundation

struct UserAClassList: Codable {
    let status: Int
    let data: UserAClass
    let errorCode: Int
}

struct UserAClass: Codable {
    let country: String
    let username: String
    let idcard: String
    let idcardauth: Int
    let idcardinfo: String
}

enum UploadIdentityText: String, CaseIterable {
    case Rule

    var text: String {
        switch self {
        case .Rule:
            return """
                上傳須知
                •  請上傳經政府發行的身分證明文件。
                •  請上傳不大於4MB的JPEG或PNG。
                •  請確認檔案符合以下條件：
                    (1) 彩色圖檔
                    (2) 證件上的信息，清晰可見，不允許任何修改和遮擋，且必須能看清楚證件號碼和姓名。
                •  您的身分證明文件一般需要 3 至 5 個工作天 (不含例假日)審核，請您耐心等候，謝謝。

                法律條款
                •  盜用他人身份者，可能涉及觸犯刑法210、211、212等法規，並面臨最高七年有期徒刑，敬請勿以身試法。
                •  因應風險控管，我們保留驗證通過與否的權利。
                """
        }
    }
}
