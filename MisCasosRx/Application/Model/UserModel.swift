//
//  UserModel.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 10/06/2022.
//

import Foundation

struct UserModel {
    var mail : String
    var country : String
    var subscriptions : [String]
    var imageCounter : Int
   // var TotalPurchasedImages : Int
    var expirationDates :[String : String] =  ["Premium": "0", "+500 Casos": "0","+1000 Casos": "0", "+2000 Casos": "0" ,"+5000 Casos": "0"]
    var lastLoginDate :String =  ""
    var vendorId : String = ""
    var identifier : String = ""
//    var alert : Bool
    
    
    
}

extension UserModel {
    init(data: [String: Any]) {
        self.mail = data["mail"] as? String ?? ""
        self.country = data["country"] as? String ?? ""
        self.subscriptions = data["subscriptions"] as? [String] ??  []
        self.imageCounter =  data["imageCounter"] as? Int  ?? 0
     //   self.TotalPurchasedImages =  data["TotalPurchasedImages"] as? Int  ?? 0
        self.expirationDates = data["expirationDates"] as? [String : String] ?? ["Premium": "0", "+500 Casos": "0","+1000 Casos": "0", "+2000 Casos": "0","+5000 Casos": "0"]
        self.lastLoginDate = data["lastLoginDate"] as? String  ?? ""
        self.vendorId = data["vendorId"] as? String ?? ""
        self.identifier = data["identifier"] as? String ?? ""
     }
}
