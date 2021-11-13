//
//  Petition.swift
//  TuTuTest
//
//  Created by Владимир Тимофеев on 13.11.2021.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
