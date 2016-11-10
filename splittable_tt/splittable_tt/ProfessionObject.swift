//
//  proffessionObject.swift
//  splittable_tt
//
//  Created by Lawrence Dawson on 10/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation

import SwiftyJSON

class ProfessionObject {
        var profession: String!
        var pictureURL: String!

    
    required init(json: JSON) {
        profession = json["name"].stringValue
        pictureURL = json["image_url"]["medium"].stringValue
    }
}