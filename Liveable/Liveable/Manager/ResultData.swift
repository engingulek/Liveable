//
//  ResultData.swift
//  Liveable
//
//  Created by engin gülek on 11.10.2023.
//

import Foundation

typealias ResultDataType = [String:ResultData]

struct ResultData : Codable {
    let name : String
}
