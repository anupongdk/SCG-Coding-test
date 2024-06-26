//
//  StringExtensionTest.swift
//  AnupongTests
//
//  Created by gone on 26/6/2567 BE.
//

import XCTest
@testable import Anupong


class StringExtensionTests: XCTestCase {

    func testConvertDateStringValidDate() {
        let dateString = "2024-06-24T12:27:00Z"
        let expectedOutput = "Jun 24, 19:09"
        let formattedDateString = dateString.convertToAppDateFormat()
        
        XCTAssertEqual(formattedDateString, expectedOutput, "The date format conversion did not produce the expected output.")
    }

    func testConvertDateStringInvalidDate() {
        let dateString = "invalid date string"
        let formattedDateString = dateString.convertToAppDateFormat()
        
        XCTAssertEqual(formattedDateString, "")
    }

}


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
