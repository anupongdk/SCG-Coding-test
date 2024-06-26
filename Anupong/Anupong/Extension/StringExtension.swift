//
//  StringExtension.swift
//  Anupong
//
//  Created by gone on 26/6/2567 BE.
//

import Foundation

extension String {
    func convertToAppDateFormat() -> String {
           let expectDateFormatter = DateFormatter()
           expectDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           expectDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
           
           if let date = expectDateFormatter.date(from: self) {
               let outputFormatter = DateFormatter()
               outputFormatter.dateFormat = "MMM dd, HH:mm"
               outputFormatter.timeZone = TimeZone.current
               
               return outputFormatter.string(from: date)
           } else {
               return ""
           }
       }
}
