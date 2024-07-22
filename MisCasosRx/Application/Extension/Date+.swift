//
//  Date+.swift
//  MisCasosRx
//
//  Created by NamTrinh on 18/07/2024.
//

import Foundation

func getTime(time : String) -> Date {
    if let timeResult =  Double(time) {
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        return  date
    }
    return Date()
}
