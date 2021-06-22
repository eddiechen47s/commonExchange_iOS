//
//  Rigster.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation

struct RegisterList: Codable {
    let status: Int
    let data: RegisterDetailList
    let errorCode: Int
}

struct RegisterDetailList: Codable {
    let status: Int
    let data: Register
    let errorCode: Int
}

struct Register: Codable {
    let username: String
    let moble: String
}

enum RegisterPhone: String, CaseIterable {
    case phone
    
    var text: [String] {
        switch self {
        case .phone:
            return ["+886",
                    "+971",
                    "+93",
                    "+1268",
                    "+1264",
                    "+54",
                    "+43",
                    "+61",
                    "+297",
                    "+880",
                    "+32",
                    "+973",
                    "+1441",
                    "+591",
                    "+55",
                    "+975",
                    "+1",
                    "+243",
                    "+41",
                    "+237",
                    "+86",
                    "+57",
                    "+49",
                    "+45",
                    "+1767",
                    "+20",
                    "+34",
                    "+33",
                    "+358",
                    "+679",
                    "+1473",
                    "+995",
                    "+233",
                    "+30",
                    "+502",
                    "+967",
                    "+852",
                    "+504",
                    "+509",
                    "+62",
                    "+353",
                    "+91",
                    "+354",
                    "+39",
                    "+964",
                    "+1876",
                    "+962",
                    "+81",
                    "+254",
                    "+975",
                    "+82",
                    "+965",
                    "+7",
                    "+1758",
                    "+94",
                    "+352",
                    "+212",
                    "+261",
                    "+389",
                    "+60",
                    "+853",
                    "+960",
                    "+52",
                    "+234",
                    "+505",
                    "+47",
                    "+674",
                    "+64",
                    "+507",
                    "+675",
                    "+92",
                    "+351",
                    "+595",
                    "+40",
                    "+7",
                    "+250",
                    "+966",
                    "+248",
                    "+249",
                    "+46",
                    "+65",
                    "+503",
                    "+381",
                    "+676",
                    "+90",
                    "+66",
                    "+380",
                    "+256",
                    "+44",
                    "+1",
                    "+598",
                    "+998",
                    "+58",
                    "+967"]
            
        }
    }
}
