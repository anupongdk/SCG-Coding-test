//
//  DataExtension.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//
import Foundation

extension Data {
    public var asUtf8String: String? {
        String(data: self, encoding: .utf8)
    }

    func printFormattedJSON() {
        do {
            let json = try JSONSerialization.jsonObject(with: self)
            let jsonObj = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            print(jsonObj.asUtf8String ?? "nil")
        } catch {
            print("error: \(error)")
        }
    }
}
